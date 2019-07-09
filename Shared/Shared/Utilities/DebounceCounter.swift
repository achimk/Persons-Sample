//
//  DebounceCounter.swift
//  Shared
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

open class DebounceCounter {
    
    private let lock = NSLock()
    private(set) var _counter: Int = 0
    public private(set) var counter: Int {
        set {
            lock.lock()
            _counter = newValue
            lock.unlock()
        }
        get {
            return _counter
        }
    }
    
    public var isStarted: Bool { return counter > 0 }
    public var isFinished: Bool { return counter == 0 }
    
    public init() { }
    
    @discardableResult
    public func start() -> Bool {
        return start(with: { })
    }
    
    @discardableResult
    public func start(with action: () -> ()) -> Bool {
        let shouldCall = counter == 0
        counter = counter + 1
        if shouldCall {
            action()
        }
        return shouldCall
    }
    
    public func start(with action: () -> (), otherwise: () -> ()) {
        if start(with: action) == false {
            otherwise()
        }
    }
    
    @discardableResult
    public func finish() -> Bool {
        return finish(with: { })
    }
    
    @discardableResult
    public func finish(with action: () -> ()) -> Bool {
        let newLimit = counter - 1
        guard newLimit >= 0 else { return false }
        counter = newLimit
        let shouldCall = newLimit == 0
        if shouldCall {
            action()
        }
        return shouldCall
    }
    
    public func finish(with action: () -> (), otherwise: () -> ()) {
        if finish(with: action) == false {
            otherwise()
        }
    }
}
