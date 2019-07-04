//
//  GetPersonsUseCase.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared
import AppCore

struct GetPersonsUseCase {
    
    let gateway: GetPersonsGateway
    
    func prepare() -> Future<[Person], ApplicationError> {
        return gateway.getPersons()
    }
}
