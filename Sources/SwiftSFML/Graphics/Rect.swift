//
// Created by travis on 10/11/20.
//

import Foundation
import CSFML

public typealias IntRect = Rect<Int32>

public struct Rect<T> {
    let left: T
    let top: T
    let width: T
    let height: T
}

extension IntRect {
    public static func fromSFRect(_ sf: sfIntRect) -> IntRect {
        IntRect(left: sf.left, top: sf.top, width: sf.width, height: sf.height)
    }

    public func toSFRect() -> sfIntRect {
        sfIntRect(left: self.left, top: self.top, width: self.width, height: self.height)
    }
}
