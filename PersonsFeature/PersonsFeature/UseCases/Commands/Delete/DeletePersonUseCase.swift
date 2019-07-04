//
//  DeletePersonUseCase.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared
import AppCore

struct DeletePersonUseCase {
    
    let ids: NonEmptyArray<PersonId>
    let token: AccessToken
    let eventDispatcher: EventDispatcher
    let gateway: DeletePersonGateway
    
    func prepare() -> Future<NonEmptyArray<PersonId>, ApplicationError> {
        
        let eventDispatcher = self.eventDispatcher
        
        return gateway
            .delete(with: ids, token: token)
            .andThen { $0.onSuccess { eventDispatcher(PersonEvent.deleted($0)) } }
    }
}
