//
// Created by travis on 10/10/20.
//

import Foundation
import CSFML

public class RenderWindow {

    var window: OpaquePointer? = nil

    init(window: OpaquePointer) {
        self.window = window
    }

    deinit {
        destroy()
    }
}


extension RenderWindow {

    public static func create(mode: VideoMode, title: String, styleSet: Set<WindowStyle>, settings: ContextSettings) -> RenderWindow? {
        var unsafeSettings = settings
        guard let window = sfRenderWindow_create(mode, title, styleSet.combine(), &unsafeSettings) else {
            return nil
        }
        return RenderWindow(window: window)
    }

    /// Construct a window from an existing control
    public static func createFromHandle(from handle: WindowHandle, contextSettings: ContextSettings) -> RenderWindow? {
        var unsafeContextSettings = contextSettings
        guard let window = sfRenderWindow_createFromHandle(handle, &unsafeContextSettings) else {
            return nil
        }
        return RenderWindow(window: window)
    }

    /// Close a window and destroy all the attached resources
    public func close() {
        guard window != nil else {
            return
        }
        sfRenderWindow_close(window)
    }

    ///  Destroy a window
    public func destroy() {
        guard self.window != nil else {
            return
        }
        sfRenderWindow_destroy(window)
        window = nil
    }

}

extension RenderWindow {

    /// Tell whether or not a window is opened
    public var isOpen: Bool {
        window != nil && sfRenderWindow_isOpen(window) == sfTrue
    }

    /// Get the position of a window
    public var position: (x:Int32, y:Int32) {
        get {
            guard window != nil else {
                return (x: 0, y: 0)
            }
            let sfVector = sfRenderWindow_getPosition(window)
            return (x: sfVector.x, y: sfVector.y)
        }
        set {
            guard window != nil else {
                return
            }
            var sfVector = sfVector2i()
            sfVector.x = newValue.x
            sfVector.y = newValue.y
            sfRenderWindow_setPosition(window, sfVector)
        }
    }

    /// Get the size of the rendering region of a window
    public var size: (width: UInt32, height: UInt32) {
        get {
            guard window != nil else {
                return (width: 0, height: 0)
            }
            let sfVector = sfRenderWindow_getSize(window)
            return (width: sfVector.x, height: sfVector.y)
        }

        set {
            guard window != nil else {
                return
            }
            var sfVector = sfVector2u()
            sfVector.x = newValue.width
            sfVector.y = newValue.height
            sfRenderWindow_setSize(window, sfVector)
        }
    }

    /// Change the title of a window
    public func setTitle(title: String) {
        guard window != nil else {
            return
        }
        title.withCString { (pointer: UnsafePointer<Int8>) -> Void in
            sfRenderWindow_setTitle(window, pointer)
        }
    }

    /// Get the OS-specific handle of the window
    public func getSystemHandle() -> WindowHandle? {
        guard window != nil else {
            return nil
        }
        return sfRenderWindow_getSystemHandle(window)
    }

    /// Get the settings of the OpenGL context of a window
    public func getSettings() -> ContextSettings? {
        guard window != nil else {
            return nil
        }

        return sfRenderWindow_getSettings(window)
    }

}

extension RenderWindow {
    /// Change the current active view of a render window
    public var view: View {
        get {
            View(sfRenderWindow_getView(self.window))
        }

        set {
            sfRenderWindow_setView(self.window, newValue.pointer)
        }
    }
    /// Get the default view of a render window
    public var defaultView: View {
        View(sfRenderWindow_getDefaultView(self.window))
    }
}

extension RenderWindow {
    public func getViewport(view: View) -> IntRect {
        let sf = sfRenderWindow_getViewport(self.window, view.pointer)
        return IntRect.fromSFRect(sf)
    }
}

extension RenderWindow {

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
        sfRenderWindow_setVisible(window, visible ? sfTrue : sfFalse)
    }

    ///  Activate or deactivate a window as the current target for OpenGL rendering
    public func setActive(active: Bool) -> Bool {
        guard window != nil else {
            return false
        }
        return sfRenderWindow_setActive(window, active ? sfTrue : sfFalse) == sfTrue
    }

    public var focus: Bool {
        get {
            guard window != nil else {
                return false
            }
            return sfRenderWindow_hasFocus(window) == sfTrue
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
        sfRenderWindow_requestFocus(window)
    }

    /// Display on screen what has been rendered to the window so far
    public func display() {
        guard window != nil else {
            return
        }
        sfRenderWindow_display(window)
    }

    /// Pop the event on top of event queue, if any, and return it
    public func pollEvent() -> Event? {
        var event = sfEvent()
        if sfRenderWindow_pollEvent(window, &event) == sfFalse {
            return nil
        }
        return Event(proxy: event)
    }

    ///  Wait for an event and return it
    public func waitEvent() -> Event? {
        var event = sfEvent()
        if sfRenderWindow_waitEvent(window, &event) == sfFalse {
            return nil
        }
        return Event(proxy: event)
    }
}


///  Draw a drawable object to the render-target
extension RenderWindow {

    public func draw(sprite: Sprite, states: RenderStates? = nil) {
        if var tempRenderStates = states {
            sfRenderWindow_drawSprite(self.window, sprite.pointer, &tempRenderStates)
        } else {
            sfRenderWindow_drawSprite(self.window, sprite.pointer, nil)
        }
    }

    // TBD
}


/// GLStatus
extension RenderWindow {

    /// Save the current OpenGL render states and matrices
    public func pushGLStates() {
        sfRenderWindow_pushGLStates(self.window)
    }

    /// Restore the previously saved OpenGL render states and matrices
    public func popGLStates() {
        sfRenderWindow_popGLStates(self.window)
    }

    /// Reset the internal OpenGL states so that the target is ready for drawing
    public func resetGLStates() {
        sfRenderWindow_resetGLStates(self.window)
    }
}
