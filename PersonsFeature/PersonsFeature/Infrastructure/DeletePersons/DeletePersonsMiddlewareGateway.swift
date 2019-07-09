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
    
    func delete(with ids: NonEmptyArray<PersonId>, token: AccessToken) -> Future<NonEmptyArray<PersonId>, ApplicationError> {
        
        // FIXME: Implement!
        fatalError()
    }
}
