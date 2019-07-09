//
//  Rule+Compare.swift
//  Shared
//
//  Created by Joachim Kret on 08/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

extension Rule where T: Comparable {
    
    public func greater(than: T, describing: (T) -> String = String.init(describing:)) -> Rule<T> {
        return apply(ValidationRuleGreater(
            target: than,
            error: CompareInputError.isLess(than: describing(than))))
    }
    
    public func greaterOrEqual(to: T, describing: (T) -> String = String.init(describing:)) -> Rule<T> {
        return apply(ValidationRuleMin(
            target: to,
            error: CompareInputError.isLessOrNotEqual(to: describing(to))))
    }
    
    public func less(than: T, describing: (T) -> String = String.init(describing:)) -> Rule<T> {
        return apply(ValidationRuleLess(
            target: than,
            error: CompareInputError.isGreater(than: describing(than))))
    }
    
    public func lessOrEqual(to: T, describing: (T) -> String = String.init(describing:)) -> Rule<T> {
        return apply(ValidationRuleMax(
            target: to,
            error: CompareInputError.isGreaterOrNotEqual(to: describing(to))))
    }
}

