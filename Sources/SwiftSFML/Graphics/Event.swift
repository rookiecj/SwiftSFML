//
// Created by travis on 10/10/20.
//

import Foundation
import CSFML

public enum EventType: UInt32 {
    public static let sfEventTypes = [
        sfEvtClosed,                 ///< The window requested to be closed (no data)
        sfEvtResized,                ///< The window was resized (data in event.size)
        sfEvtLostFocus,              ///< The window lost the focus (no data)
        sfEvtGainedFocus,            ///< The window gained the focus (no data)
        sfEvtTextEntered,            ///< A character was entered (data in event.text)
        sfEvtKeyPressed,             ///< A key was pressed (data in event.key)
        sfEvtKeyReleased,            ///< A key was released (data in event.key)
        sfEvtMouseWheelMoved,        ///< The mouse wheel was scrolled (data in event.mouseWheel) (deprecated)
        sfEvtMouseWheelScrolled,     ///< The mouse wheel was scrolled (data in event.mouseWheelScroll)
        sfEvtMouseButtonPressed,     ///< A mouse button was pressed (data in event.mouseButton)
        sfEvtMouseButtonReleased,    ///< A mouse button was released (data in event.mouseButton)
        sfEvtMouseMoved,             ///< The mouse cursor moved (data in event.mouseMove)
        sfEvtMouseEntered,           ///< The mouse cursor entered the area of the window (no data)
        sfEvtMouseLeft,              ///< The mouse cursor left the area of the window (no data)
        sfEvtJoystickButtonPressed,  ///< A joystick button was pressed (data in event.joystickButton)
        sfEvtJoystickButtonReleased, ///< A joystick button was released (data in event.joystickButton)
        sfEvtJoystickMoved,          ///< The joystick moved along an axis (data in event.joystickMove)
        sfEvtJoystickConnected,      ///< A joystick was connected (data in event.joystickConnect)
        sfEvtJoystickDisconnected,   ///< A joystick was disconnected (data in event.joystickConnect)
        sfEvtTouchBegan,             ///< A touch event began (data in event.touch)
        sfEvtTouchMoved,             ///< A touch moved (data in event.touch)
        sfEvtTouchEnded,             ///< A touch event ended (data in event.touch)
        sfEvtSensorChanged,          ///< A sensor value changed (data in event.sensor)

        sfEvtCount,                  ///< Keep last -- the total number of event types
    ]

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


public struct Event {
    let proxy: sfEvent

    public var type: EventType {
        get {
            EventType(rawValue: proxy.type.rawValue)!
        }
    }

    public var size: sfSizeEvent {
        get {

            proxy.size
        }
    }

}

