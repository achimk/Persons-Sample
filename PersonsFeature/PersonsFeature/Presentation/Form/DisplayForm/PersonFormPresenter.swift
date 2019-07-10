//
//  PersonFormPresenter.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

final class PersonFormPresenter {
    
    private let localizer: PersonFormLocalizing
    private let controller: PersonFormController
    
    private weak var ui: PersonFormUserInterface?
    private weak var wireframe: PersonFormWireframe?
    
    init(localizer: PersonFormLocalizing, controller: PersonFormController) {
        self.localizer = localizer
        self.controller = controller
    }
}

extension PersonFormPresenter: PersonFormModule {
    
    func attach(ui: PersonFormUserInterface, wireframe: PersonFormWireframe) {
        self.ui = ui
        self.wireframe = wireframe
    }
    
    func detach() {
        wireframe = nil
        ui = nil
    }
}

extension PersonFormPresenter: PersonFormModelResponse {
    
    func didUpdate(unvalidated: UnvalidatedPerson, with invalidData: InvalidPersonData?) {
        tellUserInterfaceToPresent(unvalidated: unvalidated, with: invalidData)
    }
}

extension PersonFormPresenter {
    
    private func tellUserInterfaceToPresent(unvalidated: UnvalidatedPerson, with invalidData: InvalidPersonData?) {
        let viewData = PersonFormViewDataFactory(
            localizer: localizer,
            controller: controller,
            data: unvalidated,
            invalidData: invalidData).create()
        ui?.present(viewData: viewData)
    }
}
