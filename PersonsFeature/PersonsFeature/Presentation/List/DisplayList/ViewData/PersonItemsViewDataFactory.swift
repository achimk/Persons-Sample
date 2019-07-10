//
//  PersonItemsViewDataFactory.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

struct PersonItemsViewDataFactory {
    
    let controller: PersonsListController
    let list: [Person]
    
    func create() -> PersonItemsViewData {
        return list.map(toItem)
    }
    
    private func toItem(_ person: Person) -> PersonItemViewData {
        
        let title = [person.name, person.surname].joined(separator: " ")
        let description = person.email.value
        
        let handler: PersonItemViewData.Handler = { [controller] in
            controller.selected(person)
        }
        
        return PersonItemViewData(title: title, description: description, handler: handler)
    }
}
