//
//  PersonsInteractor.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared
import AppCore

final class PersonsInteractor: PersonsAPI {
    
    private let container: PersonsInteractorContainer
    
    init(container: PersonsInteractorContainer) {
        self.container = container
    }
    
    func getPerson(with id: PersonId) -> Future<Person, ApplicationError> {
        
        return UseCase.unauthorized().create { [container] _ in
            
            // Also possible to call gateway directly:
            // return container.getPersonDetailsGateway.getPersonDetails(for: id)
            
            return GetPersonDetailsUseCase(
                id: id,
                gateway: container.getPersonDetailsGateway).prepare()
        }
    }
    
    func getAllPersons() -> Future<[Person], ApplicationError> {
        
        return UseCase.unauthorized().create { [container] (_) -> Future<[Person], ApplicationError> in
            
            // Also possible to call gateway directly:
            // return container.getPersonsGateway.getPersons()
            
            return GetPersonsUseCase(gateway: container.getPersonsGateway).prepare()
        }
    }
    
    func create(with data: UnvalidatedPerson) -> Future<PersonId, ApplicationError> {
        
        return UseCase.authorized().create { [container] (token, eventDispatcher) in
            
            return CreatePersonUseCase(
                data: data,
                token: token,
                eventDispatcher: eventDispatcher,
                gateway: container.createPersonGateway).prepare()
        }
    }
    
    func update(with id: PersonId, data: UnvalidatedPerson) -> Future<PersonId, ApplicationError> {
        
        return UseCase.authorized().create { [container] (token, eventDispatcher) in
            
            return UpdatePersonUseCase(
                id: id,
                data: data,
                token: token,
                eventDispatcher: eventDispatcher,
                gateway: container.updatePersonGateway).prepare()
        }
    }
    
    func delete(with ids: NonEmptyArray<PersonId>) -> Future<NonEmptyArray<PersonId>, ApplicationError> {
        
        return UseCase.authorized().create { [container] (token, eventDispatcher) in
            
            return DeletePersonUseCase(
                ids: ids,
                token: token,
                eventDispatcher: eventDispatcher,
                gateway: container.deletePersonGateway).prepare()
        }
    }
    
    
}
