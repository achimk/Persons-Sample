//
//  CompareInput.swift
//  Shared
//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct CompareInput<T: Comparable> {
    
    public enum Rule {
        case required
        case min(T)
        case max(T)
        case equal(T)
    }
    
    public enum Error: Swift.Error {
        case isRequired
        case isLess(than: T)
        case isGreater(than: T)
        case isNotEqual(T)
    }
}
