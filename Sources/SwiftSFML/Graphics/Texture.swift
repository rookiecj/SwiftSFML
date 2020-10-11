//
// Created by travis on 10/11/20.
//

import Foundation
import CSFML

public class Texture {
    var pointer: OpaquePointer? = nil

    public init(_ pointer: OpaquePointer) {
        self.pointer = pointer
    }

    deinit {
        destroy()
    }

    public func destroy() {
        guard pointer != nil else {
            return
        }
        sfTexture_destroy(pointer)
        pointer = nil
    }
}

extension Texture {
    public static func createFromFile(_ filename: String, area: IntRect? = nil) -> Texture? {
        filename.withCString { cfilename in
            var pointer: OpaquePointer? = nil
            if let area = area {
                var newArea = area.toSFRect()
                pointer = sfTexture_createFromFile(cfilename, &newArea)
            } else {
                pointer = sfTexture_createFromFile(cfilename, nil)
            }
            if let pointer = pointer {
                return Texture(pointer)
            } else {
                return nil
            }
        }
    }
}