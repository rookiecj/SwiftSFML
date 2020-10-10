//
// Created by travis on 10/10/20.
//

import Foundation
import CSFML

//// error: no such module 'Accelerate'
//#if canImport(Accelerate)
//import Accelerate
//#else
//#warning("no Accelerate")
//#endif

//public typealias WindowStyle = sfWindowStyle
public typealias ContextAttribute = sfContextAttribute
public typealias ContextSettings = sfContextSettings
public typealias WindowHandle = sfWindowHandle
//public typealias Event = sfEvent
public typealias IntVector = sfVector2i
public typealias FloatVector = sfVector2f

/// sfVideoMode defines a video mode (width, height, bpp, frequency)
///        and provides functions for getting modes supported
///        by the display device
public typealias VideoMode=sfVideoMode

extension VideoMode {

    /// Get the current desktop video mode
    ///
    /// return: Current desktop video mode
    public static func getDestopMode() -> VideoMode {
        sfVideoMode_getDesktopMode()
    }

    public static func getFullscreenModes(limit: Int) -> [VideoMode] {
        var results = [VideoMode]()
        var count = limit
        guard let fullscreenModes = sfVideoMode_getFullscreenModes(&count) else {
            return results
        }

        for a in 0..<count {
            results.append(fullscreenModes[a])
        }
        return results
    }
}

extension VideoMode {
    public var isValid: Bool {
        get {
            sfVideoMode_isValid(self) != 0
        }
    }
}

public enum WindowStyle: UInt32 {
    case None         = 0      ///< No border / title bar (this flag and all others are mutually exclusive)
    case Titlebar     = 1 ///< Title bar + fixed border
    case Resize       = 2 ///< Titlebar + resizable border + maximize button
    case Close        = 4 ///< Titlebar + close button
    case Fullscreen   = 8 ///< Fullscreen mode (this flag and all others are mutually exclusive)

    public static let DefaultStyleSet: Set = [Self.Titlebar, Self.Resize, Self.Close] ///< Default window style
}

extension Set where Element == WindowStyle {
    public func combine() -> UInt32 {
        self.reduce(0) { result, v in
            result + v.rawValue
        }
    }
}

public class Window {
    static let NilWindow = unsafeBitCast(0, to: OpaquePointer.self)

    var window: OpaquePointer = NilWindow

    init(window: OpaquePointer) {
        self.window = window
    }

    deinit {
        destroy()
    }
}


extension Window {

    public static func create(mode: VideoMode, title: String, styleSet: Set<WindowStyle>, settings: ContextSettings) -> Window? {
        var unsafeSettings = settings
        guard let window = sfWindow_create(mode, title, styleSet.combine(), &unsafeSettings) else {
            return nil
        }
        return Window(window: window)
    }

    /// Construct a window from an existing control
    public static func createFromHandle(handle: WindowHandle, contextSettings: ContextSettings) -> Window? {
        var unsafeContextSettings = contextSettings
        guard let window = sfWindow_createFromHandle(handle, &unsafeContextSettings) else {
            return nil
        }
        return Window(window: window)
    }

    /// Close a window and destroy all the attached resources
    public func close() {
        guard window != Window.NilWindow else {
            return
        }
        sfWindow_close(window)
    }

    ///  Destroy a window
    public func destroy() {
        guard self.window != Window.NilWindow else {
            return
        }
        sfWindow_destroy(window)
        window = Window.NilWindow
    }

}

extension Window {

    /// Tell whether or not a window is opened
    public var isOpen: Bool {
        get {
            window != Window.NilWindow && sfWindow_isOpen(window) != 0
        }
    }

    /// Get the position of a window
    public var position: (x:Int32, y:Int32) {
        get {
            guard window != Window.NilWindow else {
                return (x: 0, y: 0)
            }
            let sfVector = sfWindow_getPosition(window)
            return (x: sfVector.x, y: sfVector.y)
        }
        set {
            guard window != Window.NilWindow else {
                return
            }
            var sfVector = sfVector2i()
            sfVector.x = newValue.x
            sfVector.y = newValue.y
            sfWindow_setPosition(window, sfVector)
        }
    }

    /// Get the size of the rendering region of a window
    public var size: (width: UInt32, height: UInt32) {
        get {
            guard window != Window.NilWindow else {
                return (width: 0, height: 0)
            }
            let sfVector = sfWindow_getSize(window)
            return (width: sfVector.x, height: sfVector.y)
        }

        set {
            guard window != Window.NilWindow else {
                return
            }
            var sfVector = sfVector2u()
            sfVector.x = newValue.width
            sfVector.y = newValue.height
            sfWindow_setSize(window, sfVector)
        }
    }

    /// Change the title of a window
    public func setTitle(title: String) {
        guard window != Window.NilWindow else {
            return
        }
        title.withCString { (pointer: UnsafePointer<Int8>) -> Void in
            sfWindow_setTitle(window, pointer)
        }
    }

    /// Get the OS-specific handle of the window
    public func getSystemHandle() -> WindowHandle? {
        guard window != Window.NilWindow else {
            return nil
        }
        return sfWindow_getSystemHandle(window)
    }

    /// Get the settings of the OpenGL context of a window
    public func getSettings() -> ContextSettings {
        sfWindow_getSettings(window)
    }
}

extension Window {

    public func show() {
        setVisible(show: true)
    }

    public func hide() {
        setVisible(show: false)
    }

    public func setVisible(show visible: Bool) {
        guard window != Window.NilWindow else {
            return
        }
        sfWindow_setVisible(window, visible ? 1 : 0)
    }

    ///  Activate or deactivate a window as the current target for OpenGL rendering
    public func setActive(active: Bool) -> Bool {
        guard window != Window.NilWindow else {
            return false
        }
        return sfWindow_setActive(window, active ? 1 : 0) != 0
    }

    public var focus: Bool {
        get {
            guard window != Self.NilWindow else {
                return false
            }
            return sfWindow_hasFocus(window) != 0
        }

        set {
            guard window != Self.NilWindow else {
                return
            }
            requestFocus()
        }
    }

    /// Request the current window to be made the active foreground window
    public func requestFocus() {
        guard window != Self.NilWindow else {
            return
        }
        sfWindow_requestFocus(window)
    }

    /// Display on screen what has been rendered to the window so far
    public func display() {
        guard window != Self.NilWindow else {
            return
        }
        sfWindow_display(window)
    }

    /// Pop the event on top of event queue, if any, and return it
    public func pollEvent() -> Event? {
        var event = sfEvent()
        if sfWindow_pollEvent(window, &event) == 0 {
            return nil
        }
        return Event(proxy: event)
    }

    ///  Wait for an event and return it
    public func waitEvent() -> Event? {
        var event = sfEvent()
        if sfWindow_waitEvent(window, &event) == 0 {
            return nil
        }
        return Event(proxy: event)
    }
}

