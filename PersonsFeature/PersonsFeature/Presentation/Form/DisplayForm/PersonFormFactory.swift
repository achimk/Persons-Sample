//
//  PersonFormFactory.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

struct PersonFormFactory {
    
    struct Response {
        let module: PersonFormModule
        let dataConsumer: PersonFormDataConsumer
        let errorsConsumer: PersonFormErrorsConsumer
    }
    
    static func create(localizer: PersonFormLocalizing, submitter: @escaping PersonSubmitter) -> Response {
        
        let model = PersonFormModel(submitter: submitter)
        
        let controller = PersonFormController(model: model)
        
        let presenter = PersonFormPresenter(localizer: localizer, controller: controller)
        
        model.listener = presenter
        
        let dataConsumer = model.update(unvalidated:)
        
        let errorsConsumer = model.update(invalidData:)
        
        return Response(module: presenter, dataConsumer: dataConsumer, errorsConsumer: errorsConsumer)
    }
}
