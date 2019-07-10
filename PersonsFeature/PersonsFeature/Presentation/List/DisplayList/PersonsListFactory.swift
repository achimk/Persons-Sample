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

typealias PersonsConsumer = (Result<[Person], ApplicationError>) -> ()

struct PersonsListFactory {
    
    static func create() -> (module: PersonsListModule, consumer: PersonsConsumer) {
        
        let controller = PersonsListController()
        
        let presenter = PersonsListPresenter(controller: controller)
        
        let model = PersonsListModel()
        
        model.listener = presenter
        
        let consumer: PersonsConsumer = model.prepare(with:)
        
        return (presenter, consumer)
    }
}
