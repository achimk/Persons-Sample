//
//  PersonsListPresenter.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

final class PersonsListPresenter {
    
    private let controller: PersonsListController
    
    private weak var ui: PersonsListUserInterface?
    private weak var wireframe: PersonsListWireframe?
    
    init(controller: PersonsListController) {
        self.controller = controller
    }
}

extension PersonsListPresenter: PersonsListModule {
    
    func attach(_ ui: PersonsListUserInterface, wireframe: PersonsListWireframe) {
        self.ui = ui
        self.wireframe = wireframe
    }
    
    func detach() {
        ui = nil
        wireframe = nil
    }
}
