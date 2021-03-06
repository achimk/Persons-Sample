//
//  PersonsListPresenter.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import AppCore
import AdaptersCore
import Shared

final class PersonsListPresenter {
    
    private let localizer: PersonsListLocalizing
    private let controller: PersonsListController
    private let progress = Once.Lock()
    
    private weak var ui: PersonsListUserInterface?
    private weak var wireframe: PersonsListWireframe?
    
    init(localizer: PersonsListLocalizing, controller: PersonsListController) {
        self.localizer = localizer
        self.controller = controller
    }
}

extension PersonsListPresenter: PersonsListModule {
    
    func attach(ui: PersonsListUserInterface, wireframe: PersonsListWireframe) {
        self.ui = ui
        self.wireframe = wireframe
        self.controller.attach(wireframe: wireframe)
    }
    
    func detach() {
        controller.detach()
        wireframe = nil
        ui = nil
    }
}

extension PersonsListPresenter: PersonsListModelResponse {
    
    func didUpdate(with state: PersonsListState) {
        
        switch state {
        case .idle:
            break
        case .processing:
            tellUserInterfaceToPresentProgress()
        case .success(let list):
            tellUserInterfaceToDismissProgress()
            tellUserInterfaceToPresentPersons(list)
        case .failure(let error):
            tellUserInterfaceToDismissProgress()
            tellUserInterfaceToPresentError(error)
        }
    }
}

extension PersonsListPresenter {
    
    private func tellUserInterfaceToPresentPersons(_ list: [Person]) {
        let viewData = PersonItemsViewDataFactory(controller: controller, list: list).create()
        ui?.present(viewData: viewData)
    }
    
    private func tellUserInterfaceToPresentError(_ error: ApplicationError) {
        let viewData = ApplicationErrorViewDataFactory(error: error, localizer: localizer).create()
        ui?.present(error: viewData)
    }
    
    private func tellUserInterfaceToPresentProgress() {
        progress.lock {
            ui?.presentProgress()
        }
    }
    
    private func tellUserInterfaceToDismissProgress() {
        progress.unlock {
            ui?.dismissProgress()
        }
    }
}
