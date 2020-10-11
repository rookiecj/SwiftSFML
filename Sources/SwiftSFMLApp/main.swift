import Foundation
import SwiftSFML
import CoreFoundation

print("Hello, SFML!")

//let videoMode = VideoMode.desktop
//print("videoMode=\(videoMode)")
//videoMode=sfVideoMode(width: 1920, height: 1080, bitsPerPixel: 24)

let videoMode = VideoMode(width: 800, height: 600, bitsPerPixel: 24)
if let sharedSettings = Context.shared.settings {
    if let window = RenderWindow.create(mode: videoMode, title: "Hello SFML", styleSet: WindowStyle.defaultStyleSet , settings: sharedSettings) {
        defer {
            window.close()
            window.destroy()
        }

        let swiftLogo = Bundle.module.path(forResource: "swift", ofType: "png")
        let swiftTexture = Texture.createFromFile(swiftLogo!)
        let swiftSprite = Sprite.create()
        swiftSprite?.texture = swiftTexture!

        var quitGame = false
        let displayTimer = Timer(timeInterval: 1/60, repeats: true) { timer in
            guard !quitGame else {
                timer.invalidate()
                return
            }

            // handle user input
            if let event = window.waitEvent() {
                switch event.type {
                case .EventClosed:
                    quitGame = true
                    // quit RunLoop
                    RunLoop.main.perform {
                        CFRunLoopStop(RunLoop.current.getCFRunLoop())
                    }
                    break
                case .EvtMouseMoved:
                    break
                case .EvtResized:
                    print("\(event.size.width)x\(event.size.height)")
                default:
                    print("\(event.type)")
                }
            }

            // game logic here

            // display
            window.draw(sprite: swiftSprite!)
            window.display()
        }
        RunLoop.main.add(displayTimer, forMode: .default)

        while (!quitGame && RunLoop.main.run(mode: .default, before: .distantFuture)) {
            // no op
        }
    }
} else {
    print("settings is nil")
}

print("Game Done!")
