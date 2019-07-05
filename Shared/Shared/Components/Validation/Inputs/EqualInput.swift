//
//  EqualInput.swift
//  Shared
//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct EqualInput<T: Equatable> {
    
    public enum Rule {
        case required
        case equal(T)
    }
    
    public enum Error: Swift.Error {
        case isRequired
        case isNotEqual(T)
    }
}
