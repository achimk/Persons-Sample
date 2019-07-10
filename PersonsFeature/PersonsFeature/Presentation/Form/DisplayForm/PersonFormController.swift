//
//  PersonFormController.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

final class PersonFormController {
    
    private let model: PersonFormModel
    
    init(model: PersonFormModel) {
        self.model = model
    }
    
    func set(name value: String?) {
        model.set(name: value)
    }
    
    func set(surname value: String?) {
        model.set(surname: value)
    }
    
    func set(email value: String?) {
        model.set(email: value)
    }
    
    func set(age value: String?) {
        model.set(age: value)
    }
    
    func set(website value: String?) {
        model.set(website: value)
    }
    
    func submit() {
        model.submit()
    }
}
