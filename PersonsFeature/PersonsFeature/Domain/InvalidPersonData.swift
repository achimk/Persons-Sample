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
        case website
    }
    
    
    var errors: NonEmptyDictionary<Key, ValidationError>
    
    init?(_ input: Array<(Key, ValidationError)>) {
        if let head = input.first {
            let tail = Array(input.dropFirst())
            self = InvalidPersonData(NonEmptyArray(head, tail))
        } else {
            return nil
        }
    }
    
    init(_ input: NonEmptyArray<(Key, ValidationError)>) {
        let head = input.head
        let tail = input.tail
        
        errors = NonEmptyDictionary(head)
        tail.forEach { (pair) in
            guard errors[pair.0] == nil else { return }
            _ = errors.updateValue(pair.1, forKey: pair.0)
        }
    }
    
    func removed(_ key: Key) -> InvalidPersonData? {
        return InvalidPersonData(errors.compactMap { $0.key == key ? nil : $0 })
    }
}
