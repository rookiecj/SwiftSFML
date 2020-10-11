//
// Created by travis on 10/11/20.
//

import Foundation
import CSFML

public class Sprite {
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
        sfSprite_destroy(self.pointer)
        self.pointer = nil
    }
}


extension Sprite {
    public static func create() -> Sprite? {
        let pointer = sfSprite_create()
        if let pointer = pointer  {
            return Sprite(pointer)
        }
        return nil
    }
}

extension Sprite {
    public var position: FloatVector {
        get {
            guard pointer != nil else {
                return FloatVector()
            }
            return sfSprite_getPosition(self.pointer)
        }
        set {
            guard pointer != nil else {
                return
            }
            sfSprite_setPosition(self.pointer, newValue)
        }
    }
}


extension Sprite {

    public var color: Color {
        get {
            sfSprite_getColor(self.pointer)
        }
        set {
            sfSprite_setColor(self.pointer, newValue)
        }
    }

    public var texture: Texture {
        get {
            Texture(sfSprite_getTexture(self.pointer))
        }

        set {
            sfSprite_setTexture(self.pointer, newValue.pointer, sfFalse)
        }
    }

    public var textureAndResetRect: Texture {
        get {
            Texture(sfSprite_getTexture(self.pointer))
        }

        set {
            sfSprite_setTexture(self.pointer, newValue.pointer, sfTrue)
        }
    }

    public var textureRect: IntRect {
        get {
            IntRect.fromSFRect(sfSprite_getTextureRect(self.pointer))
        }

        set {
            sfSprite_setTextureRect(self.pointer, newValue.toSFRect())
        }
    }

}