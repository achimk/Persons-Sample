//
//  PersonValidator.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared

struct PersonValidationRules {
    
    let name = TextRule
        .required()
        .notEmpty()
        .onlyLetters()
    
    let surname = TextRule
        .required()
        .notEmpty()
        .onlyLetters()
    
    let age = Rule<UInt>
        .optional()
        .greaterOrEqual(to: 18)
        .less(than: 100)
}

func validatePerson(_ unvalidated: UnvalidatedPerson) -> Result<ValidatedPerson, InvalidPersonData> {
    
    let rules = PersonValidationRules()
    
    let validated = zip(with: ValidatedPerson.init)(
        rules.name.validate(unvalidated.name, key: InvalidPersonData.Key.name),
        rules.surname.validate(unvalidated.surname, key: InvalidPersonData.Key.surname),
        Email.from(unvalidated.email).mapErrors { (InvalidPersonData.Key.email, $0) },
        rules.age.validate(unvalidated.age, key: InvalidPersonData.Key.age)
    )
    
    switch validated {
    case .valid(let value): return .success(value)
    case .invalid(let errors): return .failure(InvalidPersonData(errors))
    }
}
