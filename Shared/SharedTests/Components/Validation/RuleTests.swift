//
//  RuleTests.swift
//  SharedTests
//
//  Created by Joachim Kret on 08/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import XCTest
import Shared

final class RuleTests: XCTestCase {
    
    struct PersonRules {
        let name = TextRule
            .create()
            .notEmpty()
            .onlyLetters()
        
        let surname = TextRule
            .create()
            .notEmpty()
            .onlyLetters()
        
        let initials = TextRule
            .create()
            .minLength(1)
            .maxLength(3)
        
        let age = Rule<UInt>
            .create()
            .greaterOrEqual(to: 18)
            .less(than: 100)
        
        let email = TextRule
            .create()
            .isEmail()
    }
    
    struct UnvalidatedPerson {
        var name: String?
        var surname: String?
        var initials: String?
        var age: UInt?
        var email: String?
    }
    
    enum PersonKey: String {
        case name
        case surname
        case initials
        case age
        case email
    }
    
    typealias InvalidData = NonEmptyDictionary<PersonKey, NonEmptyArray<ValidationError>>
    
    struct Person {
        let name: String
        let surname: String
        let initials: String?
        let age: UInt
        let email: String?
    }
    
    func testValidateSuccess() {
        let dto = UnvalidatedPerson(
            name: "Stephen",
            surname: "Hawking",
            initials: "SH",
            age: 76,
            email: "stephen.hawking@com.us")
        
        let result = validate(dto)
        
        XCTAssertTrue(result.isValid)
    }
    
    func testValidateFailure() {
        let dto = UnvalidatedPerson(
            name: nil,
            surname: "Hawking",
            initials: "SH",
            age: 176,
            email: "stephen.hawking@com.us")
        
        let result = validate(dto)
        
        XCTAssertFalse(result.isValid)
    }
    
    func testValidateKeyedSuccess() {
        let dto = UnvalidatedPerson(
            name: "Stephen",
            surname: "Hawking",
            initials: "SH",
            age: 76,
            email: "stephen.hawking@com.us")
        
        let result = validateKeyed(dto)
        
        XCTAssertTrue(result.isValid)
    }
    
    func testValidateKeyedFailure() {
        let dto = UnvalidatedPerson(
            name: nil,
            surname: "Hawking",
            initials: "SH",
            age: 176,
            email: "stephen.hawking@com.us")
        
        let result = validateKeyed(dto)
        
        XCTAssertFalse(result.isValid)
    }
    
    private func validate(_ dto: UnvalidatedPerson) -> Validated<Person, ValidationError> {
        
        let rules = PersonRules()
        
        return zip(with: Person.init(name:surname:initials:age:email:))(
            // name:
            rules.name.validate(dto.name),
            // surname:
            rules.surname.validate(dto.surname),
            // initials:
            validOn(empty: dto.initials, otherwise: rules.initials.validate),
            // age:
            rules.age.validate(dto.age),
            // email:
            validOn(empty: dto.email, otherwise: rules.email.validate)
        )
    }
    
    private func validateKeyed(_ dto: UnvalidatedPerson) -> Validated<Person, (PersonKey, ValidationError)> {
        
        let rules = PersonRules()
        
        return zip(with: Person.init(name:surname:initials:age:email:))(
            // name:
            rules.name.validate(dto.name).mapErrors { (PersonKey.name, $0) },
            // surname:
            rules.surname.validate(dto.surname).mapErrors { (PersonKey.surname, $0) },
            // initials:
            validOn(empty: dto.initials, otherwise: rules.initials.validate).mapErrors { (PersonKey.initials, $0) },
            // age:
            rules.age.validate(dto.age).mapErrors { (PersonKey.age, $0) },
            // email:
            validOn(empty: dto.email, otherwise: rules.email.validate).mapErrors { (PersonKey.email, $0) }
        )
    }
}
