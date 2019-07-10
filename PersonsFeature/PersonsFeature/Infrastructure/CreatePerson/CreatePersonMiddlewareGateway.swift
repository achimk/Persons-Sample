//
//  CreatePersonMiddlewareGateway.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import AppCore
import Shared

final class CreatePersonMiddlewareGateway: CreatePersonGateway {
    
    let repository: PersonsInMemoryRepository
    let delay: DispatchTimeInterval
    
    init(repository: PersonsInMemoryRepository, delay: DispatchTimeInterval) {
        self.repository = repository
        self.delay = delay
    }
    
    func create(with data: ValidatedPerson, token: AccessToken) -> Future<PersonId, ApplicationError> {
        
        let id = PersonId(rawValue: UUID().uuidString)
        
        let person = Person(
            id: id,
            name: data.name,
            surname: data.surname,
            email: data.email,
            age: data.age,
            website: data.website)
        
        return Future.init(value: id).andThen { [repository] (_) in
            repository.append(person)
        }.delay(delay)
    }
}
