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

typealias PersonsListProvider = () -> Future<[Person], ApplicationError>
typealias PersonsListEventSubscriber = (EventListener) -> ()

struct PreparePersonsListFactory {
    
    static func create(provider: @escaping PersonsListProvider, subscriber: PersonsListEventSubscriber) -> PersonsListModule {
        
        let (module, consumer) = PersonsListFactory.create()
        
        let model = PreparePersonsListModel(provider: provider)
        
        let controller = PreparePersonsListController(model: model)
        
        let presenter = PreparePersonsListPresenter(module: module, controller: controller, consumer: consumer)
        
        model.listener = presenter
        
        subscriber(model)
        
        return presenter
    }
}
