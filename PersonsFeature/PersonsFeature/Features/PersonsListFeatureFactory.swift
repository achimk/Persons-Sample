//
//  PersonsListFeatureFactory.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import AppCore

public struct PersonsListFeatureFactory {
    
    public static func create(with app: Application) -> PersonsListModule {

        let subscriber: (EventListener) -> () = {
            app.eventPublisher.subscribe($0)
        }
        
        let interactor = PersonsInteractorFactory.create()
        
        let personsProvider: PersonsListProvider = interactor.getAllPersons
        
        let deleteProvider: PersonsDeleteProvider = interactor.delete(with:)
        
        let module = PreparePersonsListFactory.create(personsProvider: personsProvider, deleteProvider: deleteProvider, subscriber: subscriber)
        
        return module
    }
}
