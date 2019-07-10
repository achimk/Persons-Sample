//
//  CreatePersonFeatureFactory.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared

struct CreatePersonFeatureFactory {
    
    static func create(localizer: PersonFormLocalizing) -> PersonFormModule {
        
        let interactor = PersonsInteractorFactory.create()
        
        let personProvider: PersonProvider = {
            Future(value: UnvalidatedPerson())
        }
        
        let personSubmitProvider: PersonSubmitProvider = interactor.create(with:)
        
        let module = SubmitPersonFormFactory.create(localizer: localizer, personProvider: personProvider, personSubmitProvider: personSubmitProvider)
        
        return module
    }
}
