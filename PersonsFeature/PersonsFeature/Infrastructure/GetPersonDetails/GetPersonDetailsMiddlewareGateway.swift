//
//  GetPersonDetailsMiddlewareGateway.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import AppCore
import Shared

final class GetPersonDetailsMiddlewareGateway: GetPersonDetailsGateway {
    
    let repository: PersonsInMemoryRepository
    let delay: DispatchTimeInterval
    
    init(repository: PersonsInMemoryRepository, delay: DispatchTimeInterval) {
        self.repository = repository
        self.delay = delay
    }
    
    func getPersonDetails(for id: PersonId) -> Future<Person, ApplicationError> {
        return Future.init(value: repository.find(with: id))
            .flatMap { $0.map { .success($0) } ?? .failure(.notFound) }
            .delay(delay)
    }
}
