//
//  CreatePersonUseCase.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared
import AppCore

struct CreatePersonUseCase {
    
    let data: UnvalidatedPerson
    let token: AccessToken
    let eventDispatcher: EventDispatcher
    let gateway: CreatePersonGateway
    
    func prepare() -> Future<PersonId, ApplicationError> {
        
        let eventDispatcher = self.eventDispatcher
        
        return Future.init(value: data)
            .flatMap(validatePerson)
            .mapError { ApplicationError.other($0) }
            .flatMap { [token, gateway] data in
                gateway.create(with: data, token: token)
            }
            .andThen {
                $0.onSuccess { eventDispatcher(PersonEvent.created($0)) }
            }
    }

}
