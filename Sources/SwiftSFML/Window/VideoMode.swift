//
// Created by travis on 10/11/20.
//

import Foundation
import CSFML


/// sfVideoMode defines a video mode (width, height, bpp, frequency)
///        and provides functions for getting modes supported
///        by the display device
public typealias VideoMode=sfVideoMode

extension VideoMode {

    public static let desktop: VideoMode = getDestopMode()

    /// Get the current desktop video mode
    ///
    /// return: Current desktop video mode
    public static func getDestopMode() -> VideoMode {
        sfVideoMode_getDesktopMode()
    }

    ///  Retrieve all the video modes supported in fullscreen mode
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
    // Tell whether or not a video mode is valid
    public var isValid: Bool {
        sfVideoMode_isValid(self) == sfTrue
    }
}
