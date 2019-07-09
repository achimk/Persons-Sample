//
//  Rule+Equal.swift
//  Shared
//
//  Created by Joachim Kret on 08/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

extension Rule where T: Equatable {
    
    public func equal(to: T, describing: (T) -> String = String.init(describing:)) -> Rule<T> {
        return apply(ValidationRuleEqual(
            target: to,
            error: EqualInputError.isNotEqual(to: describing(to))))
    }
    
    public func notEqual(to: T, describing: (T) -> String = String.init(describing:)) -> Rule<T> {
        return apply(ValidationRuleNotEqual(
            target: to,
            error: EqualInputError.isEqual(to: describing(to))))
    }
}
