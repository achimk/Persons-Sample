//
//  PreparePersonsListController.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

final class PreparePersonsListController {
    
    private let model: PreparePersonsListModel
    
    init(model: PreparePersonsListModel) {
        self.model = model
    }
    
    func attach() {
        model.prepare()
    }
    
    func detach() {
        // noop
    }
    
    func refresh() {
        model.prepare()
    }
}
