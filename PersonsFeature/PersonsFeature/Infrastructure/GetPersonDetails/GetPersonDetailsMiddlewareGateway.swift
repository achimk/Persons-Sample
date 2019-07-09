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
    
    func getPersonDetails(for id: PersonId) -> Future<Person, ApplicationError> {
        
        // FIXME: Implement!
        
        fatalError()
    }
}
