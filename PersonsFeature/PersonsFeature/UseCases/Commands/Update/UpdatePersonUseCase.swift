//
//  UpdatePersonUseCase.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared
import AppCore

struct UpdatePersonUseCase {
    
    let id: PersonId
    let data: UnvalidatedPerson
    let token: AccessToken
    let eventDispatcher: EventDispatcher
    let gateway: UpdatePersonGateway
    
    func prepare() -> Future<PersonId, ApplicationError> {
        
        let eventDispatcher = self.eventDispatcher
        
        return Future.init(value: data)
            .flatMap(validatePerson)
            .mapError { ApplicationError.other($0) }
            .flatMap { [id, token, gateway] data in
                gateway.update(with: id, data: data, token: token)
            }
            .andThen {
                $0.onSuccess { eventDispatcher(PersonEvent.updated($0)) }
            }
    }
}
