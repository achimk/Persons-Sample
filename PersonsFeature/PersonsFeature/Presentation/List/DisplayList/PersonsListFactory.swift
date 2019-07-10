//
//  PersonsListFactory.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import AppCore
import Shared

struct PersonsListFactory {
    
    static func create(localizer: PersonsListLocalizing, deleteConsumer: @escaping PersonsDeleteConsumer) -> (module: PersonsListModule, consumer: PersonsConsumer) {
        
        let model = PersonsListModel(deleteConsumer: deleteConsumer)
        
        let controller = PersonsListController(model: model)
        
        let presenter = PersonsListPresenter(localizer: localizer, controller: controller)
        
        model.listener = presenter
        
        let consumer: PersonsConsumer = model.prepare(with:)
        
        return (presenter, consumer)
    }
}
