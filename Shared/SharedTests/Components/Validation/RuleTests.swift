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
            .required()
            .notEmpty()
            .onlyLetters()
        
        let surname = TextRule
            .required()
            .notEmpty()
            .onlyLetters()
        
        let initials = TextRule
            .optional()
            .minLength(1)
            .maxLength(3)
        
        let age = Rule<UInt>
            .required()
            .greaterOrEqual(to: 18)
            .less(than: 100)
        
        let email = TextRule
            .optional()
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
        
        let result = validateKeyed(dto, .allErrors)
        
        XCTAssertTrue(result.isValid)
        
        print(result)
    }
    
    func testValidateKeyedFailure() {
        let dto = UnvalidatedPerson(
            name: nil,
            surname: "Hawking",
            initials: "SH",
            age: 176,
            email: "stephen.hawking@com.us")
        
        let result = validateKeyed(dto, .allErrors)
        
        XCTAssertFalse(result.isValid)
        
        print(result)
    }
    
    private func validate(_ dto: UnvalidatedPerson) -> Validated<Person, ValidationError> {
        
        let rules = PersonRules()
        
        return zip(with: Person.init(name:surname:initials:age:email:))(
            rules.name.validate(dto.name),
            rules.surname.validate(dto.surname),
            rules.initials.validate(dto.initials),
            rules.age.validate(dto.age),
            rules.email.validate(dto.email)
        )
    }
    
    private func validateKeyed(_ dto: UnvalidatedPerson, _ strategy: RuleErrorStrategy = .firstError) -> Validated<Person, (PersonKey, ValidationError)> {
        
        let rules = PersonRules()
        
        return zip(with: Person.init(name:surname:initials:age:email:))(
            rules.name.validate(dto.name, key: PersonKey.name, strategy: strategy),
            rules.surname.validate(dto.surname, key: PersonKey.surname, strategy: strategy),
            rules.initials.validate(dto.initials, key: PersonKey.initials, strategy: strategy),
            rules.age.validate(dto.age, key: PersonKey.age, strategy: strategy),
            rules.email.validate(dto.email, key: PersonKey.email, strategy: strategy)
        )
    }
}
