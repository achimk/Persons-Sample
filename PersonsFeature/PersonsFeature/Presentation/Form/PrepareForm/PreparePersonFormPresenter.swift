//
//  PreparePersonFormPresenter.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared
import AppCore
import AdaptersCore

final class PreparePersonFormPresenter {
    
    private let localizer: PersonFormLocalizing
    private let module: PersonFormModule
    private let dataConsumer: PersonFormDataConsumer
    private let controller: PreparePersonFormController
    private let prepareProgress = Once.Lock()
    private let progress = DebounceCounter()
    
    private weak var ui: PersonFormUserInterface?
    private weak var wireframe: PersonFormWireframe?
    
    init(localizer: PersonFormLocalizing,
         controller: PreparePersonFormController,
         module: PersonFormModule,
         dataConsumer: @escaping PersonFormDataConsumer) {
        
        self.localizer = localizer
        self.controller = controller
        self.module = module
        self.dataConsumer = dataConsumer
    }
}

extension PreparePersonFormPresenter: PersonFormModule {
    
    func attach(ui: PersonFormUserInterface, wireframe: PersonFormWireframe) {
        self.ui = ui
        self.wireframe = wireframe
        self.module.attach(ui: self, wireframe: self)
        self.controller.attach()
    }
    
    func detach() {
        controller.detach()
        module.detach()
        wireframe = nil
        ui = nil
    }
}

extension PreparePersonFormPresenter: PersonFormUserInterface {
    
    func present(viewData: PersonFormViewData) {
        tellUserInterfaceToPresentViewData(viewData)
    }
    
    func present(error viewData: ErrorViewData) {
        tellUserInterfaceToPresentError(viewData)
    }
    
    func presentProgress() {
        tellUserInterfaceToPresentProgress()
    }
    
    func dismissProgress() {
        tellUserInterfaceToDismissProgress()
    }
}

extension PreparePersonFormPresenter: PersonFormWireframe {
    
    func submitedPerson(with context: PersonContext) {
        wireframe?.submitedPerson(with: context)
    }
}

extension PreparePersonFormPresenter {
    
    func handle(_ state: DataState<UnvalidatedPerson, ApplicationError>) {
        
        switch state {
        case .idle:
            break
        case .processing:
            prepareProgress.lock {
                tellUserInterfaceToPresentProgress()
            }
        case .success(let data):
            prepareProgress.unlock {
                tellUserInterfaceToDismissProgress()
            }
            dataConsumer(data)
        case .failure(let error):
            prepareProgress.unlock {
                tellUserInterfaceToDismissProgress()
            }
            tellUserInterfaceToPresentError(error)
        }
    }
}

extension PreparePersonFormPresenter {
    
    private func tellUserInterfaceToPresentViewData(_ viewData: PersonFormViewData) {
        ui?.present(viewData: viewData)
    }
    
    private func tellUserInterfaceToPresentError(_ error: ApplicationError) {
        let viewData = ApplicationErrorViewDataFactory(error: error, localizer: localizer).create()
        ui?.present(error: viewData)
    }
    
    private func tellUserInterfaceToPresentError(_ viewData: ErrorViewData) {
        ui?.present(error: viewData)
    }
    
    private func tellUserInterfaceToPresentProgress() {
        progress.start {
            ui?.presentProgress()
        }
    }
    
    private func tellUserInterfaceToDismissProgress() {
        progress.finish {
            ui?.dismissProgress()
        }
    }
}
