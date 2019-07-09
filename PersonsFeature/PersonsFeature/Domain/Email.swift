//
//  Email.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared

struct Email {
    
    let value: String
    
    private init(_ input: String) {
        self.value = input
    }
    
    static func create(_ input: String?) -> Validated<Email, ValidationError> {
        return TextRule
            .create()
            .isEmail()
            .validate(input)
            .map { Email($0) }
    }
}
