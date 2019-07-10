//
//  PreparePersonFormController.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import AppCore
import AdaptersCore

final class PreparePersonFormController {
    
    private let dataStore: DataStore<UnvalidatedPerson, ApplicationError>
    
    init(dataStore: DataStore<UnvalidatedPerson, ApplicationError>) {
        self.dataStore = dataStore
    }
    
    func attach() {
        dataStore.dispatch()
    }
    
    func detach() {
        // noop
    }
    
    func refresh() {
        dataStore.dispatch()
    }
}
