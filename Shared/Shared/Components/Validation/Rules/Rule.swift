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
    private let validators: [AnyValidator]
    
    private init(isOptional: Bool = false, validators: [AnyValidator] = []) {
        self.validators = validators
    }
    
    private init(other: Rule, validator: AnyValidator) {
        self.validators = other.validators + [validator]
    }
}

extension Rule {
    
    public func validate(_ input: T?) -> Validated<T, ValidationError> {
        return validate(with: .firstError, for: input)
    }
    
    public func validateWithAllErrors(_ input: T?) -> Validated<T, ValidationError> {
        return validate(with: .allErrors, for: input)
    }
    
    public func validate(with strategy: RuleErrorStrategy, for input: T?) -> Validated<T, ValidationError> {
        switch strategy {
        case .firstError: return validateWithFirstErrorStrategy(input)
        case .allErrors: return validateWithAllErrorsStrategy(input)
        }
    }
    
    private func validateRequired(_ input: T?) -> Validated<T, ValidationError> {
        guard let value = input else { return .error(.isRequired) }
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
}

extension Rule {
    
    public static func create() -> Rule<T> {
        return Rule()
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
