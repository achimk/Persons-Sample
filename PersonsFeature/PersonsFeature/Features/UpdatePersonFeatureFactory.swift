//
//  UpdatePersonFeatureFactory.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared

public struct UpdatePersonFeatureFactory {
    
    public static func create(localizer: PersonFormLocalizing, context: PersonContext) -> PersonFormModule {
        
        let interactor = PersonsInteractorFactory.create()
        
        let personProvider: PersonProvider = { interactor.getPerson(with: context.id).map { $0.toUnvalidated() } }
        
        let personSubmitProvider: PersonSubmitProvider = curry(interactor.update(with:data:))(context.id)
        
        let module = SubmitPersonFormFactory.create(localizer: localizer, personProvider: personProvider, personSubmitProvider: personSubmitProvider)
        
        return module
    }
}
