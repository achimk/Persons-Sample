//
//  Once.swift
//  Shared
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct Once {
    
}

extension Once {
    
    public final class Lock {
        
        private let lock = NSLock()
        public private(set) var isSealed = false
        
        public init() { }
        
        public func lock(_ block: () -> () = { }) {
            toggle(true, block)
        }
        
        public func unlock(_ block: () -> () = { }) {
            toggle(false, block)
        }
        
        private func toggle(_ sealed: Bool, _ block: () -> ()) {
            
            if isSealed == sealed {
                return
            }
            
            lock.lock()
            defer { lock.unlock() }
            
            if isSealed == sealed {
                return
            }
            
            block()
            isSealed = sealed
        }
    }
}

extension Once {
    
    public final class Token {
        
        private let lock = NSLock()
        public private(set) var isSealed = false
        
        public init() { }
        
        public func run(_ block: () -> Void) {
            if isSealed {
                return
            }
            
            lock.lock()
            defer { lock.unlock() }
            
            if isSealed {
                return
            }
            
            block()
            isSealed = true
        }
    }
}


extension Once.Token: Cancellable {
    
    public var isCancelled: Bool { return isSealed }
    
    public func cancel() {
        run { }
    }
}
