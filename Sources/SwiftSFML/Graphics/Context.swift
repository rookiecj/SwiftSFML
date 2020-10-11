//
// Created by travis on 10/10/20.
//

import Foundation
import CSFML


public class Context {

    //static let NilContext = unsafeBitCast(0, to: OpaquePointer.self)

    var context: OpaquePointer? = nil

    init(context: OpaquePointer) {
        self.context = context
    }

    deinit {
        destroy()
    }

//    public static var activeContextId: UInt64 {
//        get {
//            sfContext_getActiveContextId()
//        }
//    }
}

extension Context {
    public static let shared = Context.create()!

    /// Create a new context
    public static func create() -> Context? {
        guard let context = sfContext_create() else {
            return nil
        }
        return Context(context: context)
    }

    public func destroy() {
        guard context != nil else {
            return
        }
        sfContext_destroy(context)
    }
}

extension Context {
    ///  Activate or deactivate explicitely a context
    public func setActive(active: Bool) {
        guard context != nil else {
            return
        }
        sfContext_setActive(context, active ? 1 : 0)
    }

    /// Get the settings of the context
    public var settings: ContextSettings? {
        get {
            guard context != nil else {
                return nil
            }
            return sfContext_getSettings(context)
        }
    }
}