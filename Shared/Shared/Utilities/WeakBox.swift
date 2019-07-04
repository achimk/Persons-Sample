//
//  WeakBox.swift
//  Shared
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct WeakBox: Hashable {
    
    public weak var inner: AnyObject?
    
    public init(_ inner: AnyObject) {
        self.inner = inner
    }
    
    public var hashValue: Int {
        return inner.map { ObjectIdentifier($0).hashValue } ?? 0
    }
    
    public static func ==(lhs: WeakBox, rhs: WeakBox) -> Bool {
        return lhs.inner === rhs.inner
    }
    
    public static func ==(lhs: WeakBox, rhs: AnyObject) -> Bool {
        return lhs.inner === rhs
    }
}
