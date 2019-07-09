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
        .create()
        .notEmpty()
        .onlyLetters()
    
    let surname = TextRule
        .create()
        .notEmpty()
        .onlyLetters()
}

func validatePerson(_ unvalidated: UnvalidatedPerson) -> Result<ValidatedPerson, InvalidPersonData> {
    
    typealias Error = (InvalidPersonData.Key, ValidationError)
    
    let rules = PersonValidationRules()
    
    let validated = zip(with: ValidatedPerson.init)(
        // name:
        rules.name.validate(unvalidated.name).mapErrors { (InvalidPersonData.Key.name, $0) },
        // surname:
        rules.surname.validate(unvalidated.surname).mapErrors { (InvalidPersonData.Key.surname, $0) },
        // email:
        Email.create(unvalidated.email).mapErrors { (InvalidPersonData.Key.email, $0) },
        // age:
        validOn(empty: unvalidated.age, otherwise: Age.create).mapErrors { (InvalidPersonData.Key.age, $0) },
        // website:
        validOn(empty: unvalidated.website, otherwise: Website.create).mapErrors { (InvalidPersonData.Key.website, $0) }
    )
    
    switch validated {
    case .valid(let value): return .success(value)
    case .invalid(let errors): return .failure(InvalidPersonData(errors))
    }
}
