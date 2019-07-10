//
//  SubmitPersonFormFactory.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

struct SubmitPersonFormFactory {
    
    static func create(localizer: PersonFormLocalizing,
                       personProvider: @escaping PersonProvider,
                       personSubmitProvider: @escaping PersonSubmitProvider) -> PersonFormModule {
        
        let model = SubmitPersonFormModel(provider: personSubmitProvider)
        
        let submitter: PersonSubmitter = {
            model.submit($0)
        }
        
        let response = PreparePersonFormFactory.create(localizer: localizer, provider: personProvider, submitter: submitter)
        
        let presenter = SubmitPersonFormPresenter(module: response.module, errorsConsumer: response.errorsConsumer)
        
        model.listener = presenter
        
        return presenter
    }
}
