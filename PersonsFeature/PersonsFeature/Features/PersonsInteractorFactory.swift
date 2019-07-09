//
//  PersonsInteractorFactory.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

struct PersonsInteractorFactory {
    
    static func create() -> PersonsInteractor {
        
        let container = PersonsInteractorContainer.init(
            getPersonsGateway: GetPersonMiddlewareGateway(),
            getPersonDetailsGateway: GetPersonDetailsMiddlewareGateway(),
            createPersonGateway: CreatePersonMiddlewareGateway(),
            updatePersonGateway: UpdatePersonMiddlewareGateway(),
            deletePersonGateway: DeletePersonsMiddlewareGateway())
        
        return PersonsInteractor(container: container)
    }
}
