//
//  GetPersonsMiddlewareGateway.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import AppCore
import Shared

final class GetPersonsMiddlewareGateway: GetPersonsGateway {
    
    let repository: PersonsInMemoryRepository
    let delay: DispatchTimeInterval
    
    init(repository: PersonsInMemoryRepository, delay: DispatchTimeInterval) {
        self.repository = repository
        self.delay = delay
    }
    
    func getPersons() -> Future<[Person], ApplicationError> {
        return Future.init(value: repository.all()).delay(delay)
    }
}
