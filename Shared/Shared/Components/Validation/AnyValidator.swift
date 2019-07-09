//
//  AnyValidator.swift
//  Shared
//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct AnyValidator {
    
    public let validation: (Any) throws -> ()
    
    public init(_ validator: @escaping (Any) throws -> ()) {
        validation = validator
    }
    
    public init<T: ValidationRule>(_ validationRule: T) {
        validation = { value in
            if !validationRule.validate(value as? T.Value) {
                throw validationRule.error
            }
        }
    }
    
    @discardableResult
    public func validate<Value>(_ value: Value) throws -> Value {
        try validation(value)
        return value
    }
}
