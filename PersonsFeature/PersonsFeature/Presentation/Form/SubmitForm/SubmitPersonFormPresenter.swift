//
//  SubmitPersonFormPresenter.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared
import AppCore
import AdaptersCore

final class SubmitPersonFormPresenter {
    
    private let localizer: PersonFormLocalizing
    private let module: PersonFormModule
    private let errorsConsumer: PersonFormErrorsConsumer
    private let submitProgress = Once.Lock()
    private let progress = DebounceCounter()
    
    private weak var ui: PersonFormUserInterface?
    private weak var wireframe: PersonFormWireframe?
    
    init(localizer: PersonFormLocalizing,
         module: PersonFormModule,
         errorsConsumer: @escaping PersonFormErrorsConsumer) {
        
        self.localizer = localizer
        self.module = module
        self.errorsConsumer = errorsConsumer
    }
}

extension SubmitPersonFormPresenter: PersonFormModule {
    
    func attach(ui: PersonFormUserInterface, wireframe: PersonFormWireframe) {
        self.ui = ui
        self.wireframe = wireframe
        self.module.attach(ui: self, wireframe: self)
    }
    
    func detach() {
        module.detach()
        wireframe = nil
        ui = nil
    }
}

extension SubmitPersonFormPresenter: PersonFormUserInterface {
    
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

extension SubmitPersonFormPresenter: PersonFormWireframe {
    
    func submitedPerson(with context: PersonContext) {
        wireframe?.submitedPerson(with: context)
    }
}

extension SubmitPersonFormPresenter: SubmitPersonFormModelResponse {
    
    func didUpdate(with state: DataState<PersonId, ApplicationError>) {
        switch state {
        case .idle:
            break
        case .processing:
            submitProgress.lock {
                tellUserInterfaceToPresentProgress()
            }
        case .success(let id):
            submitProgress.unlock {
                tellUserInterfaceToDismissProgress()
            }
            tellWireframePersonSubmited(with: id)
        case .failure(let error):
            submitProgress.unlock {
                tellUserInterfaceToDismissProgress()
            }
            handleError(error)
        }
    }
    
    private func handleError(_ error: ApplicationError) {
        if let invalidData = invalidDataError(from: error) {
            errorsConsumer(invalidData)
        } else {
            tellUserInterfaceToPresentError(error)
        }
    }
    
    private func invalidDataError(from error: ApplicationError) -> InvalidPersonData? {
        switch error {
        case .other(let custom): return custom as? InvalidPersonData
        default: return nil
        }
    }
}

extension SubmitPersonFormPresenter {
    
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

extension SubmitPersonFormPresenter {
    
    private func tellWireframePersonSubmited(with id: PersonId) {
        let context = PersonContext(id: id)
        wireframe?.submitedPerson(with: context)
    }
}
