//
//  DeletePersonsListPresenter.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared
import AppCore
import AdaptersCore

final class DeletePersonsListPresenter {
    
    private let module: PersonsListModule
    private let submitProgress = Once.Lock()
    private let progress = DebounceCounter()
    
    private weak var ui: PersonsListUserInterface?
    private weak var wireframe: PersonsListWireframe?
    
    init(module: PersonsListModule) {
        self.module = module
    }
}

extension DeletePersonsListPresenter: PersonsListModule {
    func attach(ui: PersonsListUserInterface, wireframe: PersonsListWireframe) {
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

extension DeletePersonsListPresenter: PersonsListUserInterface {
    
    func present(viewData: PersonItemsViewData) {
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

extension DeletePersonsListPresenter: PersonsListWireframe {
    
    func selectedPerson(with context: PersonContext) {
        wireframe?.selectedPerson(with: context)
    }
}

extension DeletePersonsListPresenter: DeletePersonsListModelResponse {
    
    func didUpdate(with state: DataState<NonEmptyArray<PersonId>, ApplicationError>) {
        switch state {
        case .idle:
            break
        case .processing:
            submitProgress.lock {
                tellUserInterfaceToPresentProgress()
            }
        case .success(let ids):
            submitProgress.unlock {
                tellUserInterfaceToDismissProgress()
            }
            tellWireframeDeletedPersons(ids)
        case .failure(let error):
            submitProgress.unlock {
                tellUserInterfaceToDismissProgress()
            }
            tellUserInterfaceToPresentError(error)
        }
    }
}

extension DeletePersonsListPresenter {
    
    private func tellUserInterfaceToPresentViewData(_ viewData: PersonItemsViewData) {
        ui?.present(viewData: viewData)
    }
    
    private func tellUserInterfaceToPresentError(_ error: ApplicationError) {
        // FIXME: Present error to UI!
        print("-> error: \(error)")
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

extension DeletePersonsListPresenter {
    
    private func tellWireframeDeletedPersons(_ ids: NonEmptyArray<PersonId>) {
        // FIXME: Call wireframe!
    }
}
