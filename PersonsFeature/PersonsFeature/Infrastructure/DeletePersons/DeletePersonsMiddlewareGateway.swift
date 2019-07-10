//
//  DeletePersonsMiddlewareGateway.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import AppCore
import Shared

final class DeletePersonsMiddlewareGateway: DeletePersonGateway {
    
    let repository: PersonsInMemoryRepository
    let delay: DispatchTimeInterval
    
    init(repository: PersonsInMemoryRepository, delay: DispatchTimeInterval) {
        self.repository = repository
        self.delay = delay
    }
    
    func delete(with ids: NonEmptyArray<PersonId>, token: AccessToken) -> Future<NonEmptyArray<PersonId>, ApplicationError> {

        return Future.init(value: ids).flatMap { [repository] (ids) -> Result<NonEmptyArray<PersonId>, ApplicationError> in
            var result: Result<NonEmptyArray<PersonId>, ApplicationError> = .failure(.notFound)
            
            ids.forEach { (id) in
                if repository.remove(with: id) {
                    result.onFailure { _ in
                        result = .success(NonEmptyArray(id))
                    }
                    result.onSuccess({ (ids) in
                        let ids = ids + [id]
                        result = .success(ids)
                    })
                }
            }
            
            return result
        }.delay(delay)
    }
}
