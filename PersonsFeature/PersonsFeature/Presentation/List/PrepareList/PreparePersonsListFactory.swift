//
//  PreparePersonsListFactory.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import AppCore
import Shared

struct PreparePersonsListFactory {
    
    static func create(localizer: PersonsListLocalizing,
                       personsProvider: @escaping PersonsListProvider,
                       deleteProvider: @escaping PersonsDeleteProvider,
                       subscriber: PersonsListEventSubscriber) -> PersonsListModule {
        
        let (module, consumer) = DeletePersonsListFactory.create(localizer: localizer, provider: deleteProvider)
        
        let model = PreparePersonsListModel(provider: personsProvider)
        
        let controller = PreparePersonsListController(model: model)
        
        let presenter = PreparePersonsListPresenter(module: module, controller: controller, consumer: consumer)
        
        model.listener = presenter
        
        subscriber(model)
        
        return presenter
    }
}
