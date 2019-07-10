//
//  PreparePersonFormFactory.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import AdaptersCore

struct PreparePersonFormFactory {
    
    struct Response {
        let module: PersonFormModule
        let dataConsumer: PersonFormDataConsumer
        let errorsConsumer: PersonFormErrorsConsumer
    }
    
    static func create(localizer: PersonFormLocalizing, provider: @escaping PersonProvider, submitter: @escaping PersonSubmitter) -> Response {
        
        let response = PersonFormFactory.create(localizer: localizer, submitter: submitter)
        
        let dataStore = DataStore(provider)
        
        let controller = PreparePersonFormController(dataStore: dataStore)
        
        let presenter = PreparePersonFormPresenter(controller: controller, module: response.module, dataConsumer: response.dataConsumer)
        
        dataStore.subscribe { [weak presenter] (oldState, newState) in
            presenter?.handle(newState)
        }
        
        return Response(module: presenter, dataConsumer: response.dataConsumer, errorsConsumer: response.errorsConsumer)
    }
}
