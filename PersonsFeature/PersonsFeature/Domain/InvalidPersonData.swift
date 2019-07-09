//
//  InvalidPersonData.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared

struct InvalidPersonData: Swift.Error {
    
    enum Key: String {
        case name
        case surname
        case email
        case age
    }
    
    
    var errors: NonEmptyDictionary<Key, ValidationError>
    
    init(_ input: NonEmptyArray<(Key, ValidationError)>) {
        let head = input.head
        let tail = input.tail
        
        errors = NonEmptyDictionary(head)
        tail.forEach { (pair) in
            guard errors[pair.0] == nil else { return }
            _ = errors.updateValue(pair.1, forKey: pair.0)
        }
    }
}
