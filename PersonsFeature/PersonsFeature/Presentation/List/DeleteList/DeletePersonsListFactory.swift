//
//  DeletePersonsListFactory.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

struct DeletePersonsListFactory {
    
    static func create(localizer: PersonsListLocalizing, provider: @escaping PersonsDeleteProvider) -> (module: PersonsListModule, consumer: PersonsConsumer) {
        
        let model = DeletePersonsListModel(provider: provider)
        
        let deleteConsumer: PersonsDeleteConsumer = {
            model.submit($0)
        }
        
        let (module, consumer) = PersonsListFactory.create(localizer: localizer, deleteConsumer: deleteConsumer)
        
        let presenter = DeletePersonsListPresenter(localizer: localizer, module: module)
        
        model.listener = presenter
        
        return (presenter, consumer)
    }
}
