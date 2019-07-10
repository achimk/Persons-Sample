//
//  UpdatePersonMiddlewareGateway.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import AppCore
import Shared

final class UpdatePersonMiddlewareGateway: UpdatePersonGateway {
    
    let repository: PersonsInMemoryRepository
    let delay: DispatchTimeInterval
    
    init(repository: PersonsInMemoryRepository, delay: DispatchTimeInterval) {
        self.repository = repository
        self.delay = delay
    }

    func update(with id: PersonId, data: ValidatedPerson, token: AccessToken) -> Future<PersonId, ApplicationError> {
        
        let person = Person(
            id: id,
            name: data.name,
            surname: data.surname,
            email: data.email,
            age: data.age,
            website: data.website)
        
        return Future.init(value: id).flatMap { [repository] _ in
            return repository.update(person, with: id) ? Future.init(value: id) : Future.init(error: .notFound)
        }.delay(delay)
    }
}
