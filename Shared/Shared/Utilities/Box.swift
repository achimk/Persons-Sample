//
//  Box.swift
//  Shared
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public class Box<T> {
    
    public fileprivate(set) var value: T
    
    public init(_ value: T) {
        self.value = value
    }
}

public class MutableBox<T>: Box<T> {
    
    public func set(_ value: T) {
        self.value = value
    }
}
