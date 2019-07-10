//
//  Person.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared

typealias PersonId = Tagged<Person, String>

struct Person {
    let id: PersonId
    let name: String
    let surname: String
    let email: Email
    let age: Age?
    let website: Website?
}

extension Person {
    
    func toUnvalidated() -> UnvalidatedPerson {
        return UnvalidatedPerson(
            name: name,
            surname: surname,
            email: email.value,
            age: age.map { String(describing: $0) },
            website: website.map { $0.url.absoluteString })
    }
}
