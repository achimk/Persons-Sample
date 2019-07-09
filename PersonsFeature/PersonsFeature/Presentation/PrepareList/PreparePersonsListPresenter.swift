//
//  PreparePersonsListPresenter.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

final class PreparePersonsListPresenter {
    
    private let controller: PreparePersonsListController
    
    init(controller: PreparePersonsListController) {
        self.controller = controller
    }
}

extension PreparePersonsListPresenter: PersonsListModule {
    
    func attach(_ ui: PersonsListUserInterface, wireframe: PersonsListWireframe) {
        
    }
    
    func detach() {
        
    }
}
