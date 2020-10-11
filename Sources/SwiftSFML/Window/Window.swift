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

public enum WindowStyle: UInt32 {
    case None         = 0      ///< No border / title bar (this flag and all others are mutually exclusive)
    case Titlebar     = 1 ///< Title bar + fixed border
    case Resize       = 2 ///< Titlebar + resizable border + maximize button
    case Close        = 4 ///< Titlebar + close button
    case Fullscreen   = 8 ///< Fullscreen mode (this flag and all others are mutually exclusive)

    public static let defaultStyleSet: Set = [Self.Titlebar, Self.Resize, Self.Close] ///< Default window style
}

extension Set where Element == WindowStyle {
    public func combine() -> UInt32 {
        self.reduce(0) { result, v in
            result | v.rawValue
        }
    }
}

public class Window {

    var window: OpaquePointer? = nil

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
    public static func createFromHandle(from handle: WindowHandle, contextSettings: ContextSettings) -> Window? {
        var unsafeContextSettings = contextSettings
        guard let window = sfWindow_createFromHandle(handle, &unsafeContextSettings) else {
            return nil
        }
        return Window(window: window)
    }

    /// Close a window and destroy all the attached resources
    public func close() {
        guard window != nil else {
            return
        }
        sfWindow_close(window)
    }

    ///  Destroy a window
    public func destroy() {
        guard self.window != nil else {
            return
        }
        sfWindow_destroy(window)
        window = nil
    }

}

extension Window {

    /// Tell whether or not a window is opened
    public var isOpen: Bool {
        window != nil && sfWindow_isOpen(window) == sfTrue
    }

    /// Get the position of a window
    public var position: (x:Int32, y:Int32) {
        get {
            guard window != nil else {
                return (x: 0, y: 0)
            }
            let sfVector = sfWindow_getPosition(window)
            return (x: sfVector.x, y: sfVector.y)
        }
        set {
            guard window != nil else {
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
            guard window != nil else {
                return (width: 0, height: 0)
            }
            let sfVector = sfWindow_getSize(window)
            return (width: sfVector.x, height: sfVector.y)
        }

        set {
            guard window != nil else {
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
        guard window != nil else {
            return
        }
        title.withCString { (pointer: UnsafePointer<Int8>) -> Void in
            sfWindow_setTitle(window, pointer)
        }
    }

    /// Get the OS-specific handle of the window
    public func getSystemHandle() -> WindowHandle? {
        guard window != nil else {
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
        guard window != nil else {
            return
        }
        sfWindow_setVisible(window, visible ? sfTrue : sfFalse)
    }

    ///  Activate or deactivate a window as the current target for OpenGL rendering
    public func setActive(active: Bool) -> Bool {
        guard window != nil else {
            return false
        }
        return sfWindow_setActive(window, active ? sfTrue : sfFalse) == sfTrue
    }

    public var focus: Bool {
        get {
            guard window != nil else {
                return false
            }
            return sfWindow_hasFocus(window) == sfTrue
        }

        set {
            guard window != nil else {
                return
            }
            requestFocus()
        }
    }

    /// Request the current window to be made the active foreground window
    public func requestFocus() {
        guard window != nil else {
            return
        }
        sfWindow_requestFocus(window)
    }

    /// Display on screen what has been rendered to the window so far
    public func display() {
        guard window != nil else {
            return
        }
        sfWindow_display(window)
    }

    /// Pop the event on top of event queue, if any, and return it
    public func pollEvent() -> Event? {
        var event = sfEvent()
        if sfWindow_pollEvent(window, &event) == sfFalse {
            return nil
        }
        return Event(proxy: event)
    }

    ///  Wait for an event and return it
    public func waitEvent() -> Event? {
        var event = sfEvent()
        if sfWindow_waitEvent(window, &event) == sfFalse {
            return nil
        }
        return Event(proxy: event)
    }
}

