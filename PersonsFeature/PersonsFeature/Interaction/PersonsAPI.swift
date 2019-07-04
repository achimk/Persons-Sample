//
//  PersonsAPI.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared
import AppCore

protocol PersonsAPI {
    
    // Queries
    func getPerson(with id: PersonId) -> Future<Person, ApplicationError>
    func getAllPersons() -> Future<[Person], ApplicationError>
    
    // Commands
    func create(with data: UnvalidatedPerson) -> Future<PersonId, ApplicationError>
    func update(with id: PersonId, data: UnvalidatedPerson) -> Future<PersonId, ApplicationError>
    func delete(with ids: NonEmptyArray<PersonId>) -> Future<NonEmptyArray<PersonId>, ApplicationError>
}
