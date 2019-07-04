//
//  Filter.swift
//  Shared
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public typealias FilterPredicate<T> = (T) -> Bool

public func composeFilter <T>(_ f: @escaping FilterPredicate<T>, _ g: @escaping FilterPredicate<T>) -> FilterPredicate<T> {
    
    return { x in
        
        return f(x) ? g(x) : false
    }
}

public struct Filter {
    
    private init() { }
}

extension Filter {
    
    public static func passingAll<T>(_ candidate: T) -> Bool {
        return true
    }
    
    public static func passingNone<T>(_ candidate: T) -> Bool {
        return false
    }
}
