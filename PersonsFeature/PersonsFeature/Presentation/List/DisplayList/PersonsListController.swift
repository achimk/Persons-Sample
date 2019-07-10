//
//  PersonsListController.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

final class PersonsListController {
    
    private let model: PersonsListModel
    private weak var wireframe: PersonsListWireframe?
    
    init(model: PersonsListModel) {
        self.model = model
    }
    
    func attach(wireframe: PersonsListWireframe) {
        self.wireframe = wireframe
    }
    
    func detach() {
        self.wireframe = nil
    }
    
    func select(_ person: Person) {
        let context = PersonContext(id: person.id)
        wireframe?.selectedPerson(with: context)
    }
    
    func delete(_ person: Person) {
        model.delete(person)
    }
}
