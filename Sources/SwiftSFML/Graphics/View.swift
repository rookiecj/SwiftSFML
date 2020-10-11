//
// Created by travis on 10/11/20.
//

import Foundation
import CSFML

public class View {
    var pointer: OpaquePointer? = nil
    public init(_ pointer: OpaquePointer) {
        self.pointer = pointer
    }

    deinit {
        destroy()
    }

    public func destroy() {
        guard self.pointer != nil else {
            return
        }
        sfView_destroy(self.pointer)
        self.pointer = nil
    }
}