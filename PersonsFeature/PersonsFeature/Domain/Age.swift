//
//  Age.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared

struct Age {
    
    let value: UInt
    
    private init(_ input: UInt) {
        self.value = input
    }
    
    static func create(_ input: UInt?) -> Validated<Age, ValidationError> {
        return Rule<UInt>
            .create()
            .greaterOrEqual(to: 18)
            .less(than: 100)
            .validate(input)
            .map { Age($0) }
    }
    
    static func create(_ input: String?) -> Validated<Age, ValidationError> {
        return TextRule
            .create()
            .notEmpty()
            .onlyDigits()
            .validate(input)
            .flatMap { create(UInt($0)) }
    }
}
