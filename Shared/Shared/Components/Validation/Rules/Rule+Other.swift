//
//  Rule+Other.swift
//  Shared
//
//  Created by Joachim Kret on 08/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

extension Rule {
    
    public func must<R: ValidationRule>(_ validationRule: R) -> Rule<T> where R.Value == T {
        return apply(validationRule)
    }
    
    public func must<E: Swift.Error>(_ f: @escaping (T?) -> Bool, with error: E) -> Rule<T> {
        return apply(ValidationRuleCondition(error: error, condition: f))
    }
}
