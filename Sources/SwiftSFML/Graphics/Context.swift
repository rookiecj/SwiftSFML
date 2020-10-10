//
// Created by travis on 10/10/20.
//

import Foundation
import CSFML


public struct Context {

    //static let NilContext = OpaquePointer(bitPattern: 0)!
    static let NilContext = unsafeBitCast(0, to: OpaquePointer.self)

    var context: OpaquePointer = NilContext

    public static let shared = Context.create()!

//    public static var activeContextId: UInt64 {
//        get {
//            sfContext_getActiveContextId()
//        }
//    }
}

extension Context {

    /// Create a new context
    public static func create() -> Context? {
        guard let context = sfContext_create() else {
            return nil
        }
        return Context(context: context)
    }

    public mutating func destroy() {
        guard context != Self.NilContext else {
            return
        }
        sfContext_destroy(context)
        context = Self.NilContext
    }
}

extension Context {
    ///  Activate or deactivate explicitely a context
    public func setActive(active: Bool) {
        guard context != Self.NilContext else {
            return
        }
        sfContext_setActive(context, active ? 1 : 0)
    }

    /// Get the settings of the context
    public var settings: ContextSettings? {
        get {
            guard context != Self.NilContext else {
                return nil
            }
            return sfContext_getSettings(context)
        }
    }
}