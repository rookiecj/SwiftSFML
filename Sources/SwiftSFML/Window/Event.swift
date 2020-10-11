//
// Created by travis on 10/10/20.
//

import Foundation
import CSFML

public enum EventType: sfEventType.RawValue, CaseIterable {

    case EventClosed,
         EvtResized,                ///< The window was resized (data in event.size)
         EvtLostFocus,              ///< The window lost the focus (no data)
         EvtGainedFocus,            ///< The window gained the focus (no data)
         EvtTextEntered,            ///< A character was entered (data in event.text)
         EvtKeyPressed,             ///< A key was pressed (data in event.key)
         EvtKeyReleased,            ///< A key was released (data in event.key)
         EvtMouseWheelMoved,        ///< The mouse wheel was scrolled (data in event.mouseWheel) (deprecated)
         EvtMouseWheelScrolled,     ///< The mouse wheel was scrolled (data in event.mouseWheelScroll)
         EvtMouseButtonPressed,     ///< A mouse button was pressed (data in event.mouseButton)
         EvtMouseButtonReleased,    ///< A mouse button was released (data in event.mouseButton)
         EvtMouseMoved,             ///< The mouse cursor moved (data in event.mouseMove)
         EvtMouseEntered,           ///< The mouse cursor entered the area of the window (no data)
         EvtMouseLeft,              ///< The mouse cursor left the area of the window (no data)
         EvtJoystickButtonPressed,  ///< A joystick button was pressed (data in event.joystickButton)
         EvtJoystickButtonReleased, ///< A joystick button was released (data in event.joystickButton)
         EvtJoystickMoved,          ///< The joystick moved along an axis (data in event.joystickMove)
         EvtJoystickConnected,      ///< A joystick was connected (data in event.joystickConnect)
         EvtJoystickDisconnected,   ///< A joystick was disconnected (data in event.joystickConnect)
         EvtTouchBegan,             ///< A touch event began (data in event.touch)
         EvtTouchMoved,             ///< A touch moved (data in event.touch)
         EvtTouchEnded,             ///< A touch event ended (data in event.touch)
         EvtSensorChanged,          ///< A sensor value changed (data in event.sensor)

         EvtCount                  ///< Keep last -- the total number of event types
}

public class Event {
    let proxy: sfEvent

    public init(proxy: sfEvent) {
        self.proxy = proxy
    }

    public var type: EventType {
        EventType(rawValue: proxy.type.rawValue)!
    }
}

/// Size event parameters
public protocol SizeEvent {
    var size: sfSizeEvent { get }
}

/// Keyboard event parameters
public protocol KeyEvent {
    var key: sfKeyEvent { get }
}

/// Text event parameters
public protocol TextEvent {
    var text: sfTextEvent { get }
}

/// Mouse move event parameters
public protocol MouseMoveEvent {
    var mouseMove: sfMouseMoveEvent { get }
}

/// Mouse button event parameters
public protocol MouseButtonEvent {
    var mouseButton: sfMouseButtonEvent { get }
}

/// Mouse wheel event parameters (deprecated)
@available(*, deprecated, message: "Use MouseWheelScrollEvent instead")
public protocol MouseWheelEvent {
    var mouseWheel: sfMouseWheelEvent { get }
}

/// Mouse wheel event parameters
public protocol MouseWheelScrollEvent {
    var mouseWheelScroll: sfMouseWheelScrollEvent { get }
}

public protocol JoystickMoveEvent {
    var joystickMove: sfJoystickMoveEvent { get }
}

public protocol JoystickButtonEvent {
    var joystickButton: sfJoystickButtonEvent { get }
}

public protocol JoystickConnectEvent {
    var joystickConnect: sfJoystickConnectEvent { get }
}

public protocol TouchEvent {
    var touch: sfTouchEvent { get }
}

public protocol SensorEvent {
    var sensor: sfSensorEvent { get }
}

extension Event: SizeEvent {
    public var size: sfSizeEvent {
        proxy.size
    }
}

extension Event: KeyEvent {
    public var key: sfKeyEvent {
        proxy.key
    }
}

extension Event: TextEvent {
    public var text: sfTextEvent {
        proxy.text
    }
}

extension Event: MouseMoveEvent {
    public var mouseMove: sfMouseMoveEvent {
        proxy.mouseMove
    }
}

extension Event: MouseButtonEvent {
    public var mouseButton: sfMouseButtonEvent {
        proxy.mouseButton
    }
}

extension Event: MouseWheelScrollEvent {
    public var mouseWheelScroll: sfMouseWheelScrollEvent {
        proxy.mouseWheelScroll
    }
}

extension Event: JoystickMoveEvent {
    public var joystickMove: sfJoystickMoveEvent {
        proxy.joystickMove
    }
}

extension Event: JoystickButtonEvent {
    public var joystickButton: sfJoystickButtonEvent {
        proxy.joystickButton
    }
}

extension Event: JoystickConnectEvent {
    public var joystickConnect: sfJoystickConnectEvent {
        proxy.joystickConnect
    }
}

extension Event: TouchEvent {
    public var touch: sfTouchEvent {
        proxy.touch
    }
}

extension Event: SensorEvent {
    public var sensor: sfSensorEvent {
        proxy.sensor
    }
}
