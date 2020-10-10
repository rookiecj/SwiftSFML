import Foundation
import SwiftSFML

print("Hello, SFML!")

//var videoMode = VideoMode(width: 1024, height: 768, bitsPerPixel:16)
//print("videoMode=\(videoMode)")

let videoMode = VideoMode.getDestopMode()
if let sharedSettings = Context.shared.settings {
    if var window = Window.create(mode: videoMode, title: "Hello SFML", styleSet: WindowStyle.DefaultStyleSet , settings: sharedSettings) {
        defer {
            window.close()
            window.destroy()
        }

        window.display()

        loop: while true {
            if let event = window.waitEvent() {
                switch event.type {
                case .EventClosed:
                    break loop
                case .EvtResized:
                    print("\(event.size.width)x\(event.size.height)")
                default:
                    print("\(event.type)")
                }
            }
        }
    }
} else {
    print("settings is nil")
}

