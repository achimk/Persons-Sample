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
    
    func create(with data: ValidatedPerson, token: AccessToken) -> Future<PersonId, ApplicationError> {
        
        // FIXME: Implement!
        fatalError()
    }
}
