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
        
        let delay: DispatchTimeInterval = .seconds(1)
        let repository = PersonsInMemoryRepository()
        
        let container = PersonsInteractorContainer.init(
            getPersonsGateway: GetPersonsMiddlewareGateway(repository: repository, delay: delay),
            getPersonDetailsGateway: GetPersonDetailsMiddlewareGateway(repository: repository, delay: delay),
            createPersonGateway: CreatePersonMiddlewareGateway(repository: repository, delay: delay),
            updatePersonGateway: UpdatePersonMiddlewareGateway(repository: repository, delay: delay),
            deletePersonGateway: DeletePersonsMiddlewareGateway(repository: repository, delay: delay))
        
        return PersonsInteractor(container: container)
    }
}
