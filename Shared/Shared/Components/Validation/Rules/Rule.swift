//
//  PersonValidator.swift
//  Shared
//
//  Created by Joachim Kret on 06/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public enum RuleErrorStrategy {
    case firstError
    case allErrors
}

public struct Rule<T> {
    
    private let isOptional: Bool
    private let validators: [AnyValidator]
    
    private init(isOptional: Bool = false, validators: [AnyValidator] = []) {
        self.isOptional = isOptional
        self.validators = validators
    }
    
    private init(other: Rule, validator: AnyValidator) {
        self.isOptional = other.isOptional
        self.validators = other.validators + [validator]
    }
}

extension Rule {
    
    public func validate(_ input: T?, strategy: RuleErrorStrategy = .firstError) -> Validated<T, ValidationError> {
        switch strategy {
        case .firstError: return validateWithFirstErrorStrategy(input)
        case .allErrors: return validateWithAllErrorsStrategy(input)
        }
    }
    
    public func validate(_ input: T?, strategy: RuleErrorStrategy = .firstError) -> Validated<T?, ValidationError> {
        switch strategy {
        case .firstError: return validateOptionalWithFirstErrorStrategy(input)
        case .allErrors: return validateOptionalWithAllErrorsStrategy(input)
        }
    }
    
    public func validate<K: Hashable>(_ input: T?, key: K, strategy: RuleErrorStrategy = .firstError) -> Validated<T, (K, ValidationError)> {
        
        let mapKeyedErrors: (Validated<T, ValidationError>) -> Validated<T, (K, ValidationError)> = {
            $0.mapErrors { (key, $0) }
        }
        
        switch strategy {
        case .firstError: return mapKeyedErrors(validateWithFirstErrorStrategy(input))
        case .allErrors: return mapKeyedErrors(validateWithAllErrorsStrategy(input))
        }
    }
    
    public func validate<K: Hashable>(_ input: T?, key: K, strategy: RuleErrorStrategy = .firstError) -> Validated<T?, (K, ValidationError)> {
        
        let mapKeyedErrors: (Validated<T?, ValidationError>) -> Validated<T?, (K, ValidationError)> = {
            $0.mapErrors { (key, $0) }
        }
        
        switch strategy {
        case .firstError: return mapKeyedErrors(validateOptionalWithFirstErrorStrategy(input))
        case .allErrors: return mapKeyedErrors(validateOptionalWithAllErrorsStrategy(input))
        }
    }
    
    private func validateRequired(_ input: T?) -> Validated<T, ValidationError> {
        guard let value = input else { return .error(.isRequired) }
        return .valid(value)
    }
    
    private func validateOptional(_ input: T?) -> Validated<T?, ValidationError> {
        guard let value = input else { return isOptional ? .valid(input) : .error(.isRequired) }
        return .valid(value)
    }
    
    private func validateWithFirstErrorStrategy(_ input: T?) -> Validated<T, ValidationError> {
        let result = validateRequired(input)
        guard result.isValid else { return result }
        
        do {
            try validators.forEach({ (validator) in
                try validator.validate(input)
            })
        } catch {
            return .error(ValidationError.from(error))
        }
        
        return result
    }
    
    private func validateOptionalWithFirstErrorStrategy(_ input: T?) -> Validated<T?, ValidationError> {
        let result = validateOptional(input)
        guard result.isValid else { return result }
        
        do {
            try validators.forEach({ (validator) in
                try validator.validate(input)
            })
        } catch {
            return .error(ValidationError.from(error))
        }
        
        return result
    }
    
    private func validateWithAllErrorsStrategy(_ input: T?) -> Validated<T, ValidationError> {
        var result = validateRequired(input)
        
        validators.forEach { (validator) in
            do {
                try validator.validate(input)
            } catch {
                let current = NonEmptyArray(ValidationError.from(error))
                let er = result.errors.map { $0 + current } ?? current
                result = .invalid(er)
            }
        }
        
        return result
    }
    
    private func validateOptionalWithAllErrorsStrategy(_ input: T?) -> Validated<T?, ValidationError> {
        var result = validateOptional(input)
        
        validators.forEach { (validator) in
            do {
                try validator.validate(input)
            } catch {
                let current = NonEmptyArray(ValidationError.from(error))
                let er = result.errors.map { $0 + current } ?? current
                result = .invalid(er)
            }
        }
        
        return result
    }
}

extension Rule {
    
    public static func required() -> Rule<T> {
        return Rule()
    }
    
    public static func optional() -> Rule<T> {
        return Rule(isOptional: true)
    }
}

extension Rule {
    
    internal func apply<R: ValidationRule>(_ rule: R) -> Rule<T> where R.Value == T {
        return apply(rule.asValidator())
    }
    
    internal func apply(_ validator: AnyValidator) -> Rule<T> {
        return Rule(other: self, validator: validator)
    }
}
