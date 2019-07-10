//
//  PreparePersonsListPresenter.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared
import AppCore
import AdaptersCore

final class PreparePersonsListPresenter {
    
    private let consumer: PersonsConsumer
    private let module: PersonsListModule
    private let controller: PreparePersonsListController
    private let prepareProgress = Once.Lock()
    private let progress = DebounceCounter()
    
    private weak var ui: PersonsListUserInterface?
    private weak var wireframe: PersonsListWireframe?
    
    init(module: PersonsListModule, controller: PreparePersonsListController, consumer: @escaping PersonsConsumer) {
        self.consumer = consumer
        self.module = module
        self.controller = controller
    }
}

extension PreparePersonsListPresenter: PersonsListModule {
    
    func attach(_ ui: PersonsListUserInterface, wireframe: PersonsListWireframe) {
        self.ui = ui
        self.wireframe = wireframe
        self.module.attach(self, wireframe: self)
        self.controller.attach()
    }
    
    func detach() {
        self.controller.detach()
        self.module.detach()
        wireframe = nil
        ui = nil
    }
}

extension PreparePersonsListPresenter: PersonsListUserInterface {
    
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

extension PreparePersonsListPresenter: PersonsListWireframe {
    
    func selectedPerson(with context: PersonContext) {
        wireframe?.selectedPerson(with: context)
    }
}

extension PreparePersonsListPresenter: PreparePersonsListModelResponse {
    
    func didUpdate(with state: PreparePersonsListState) {
        
        switch state {
        case .idle:
            break
        case .processing:
            prepareProgress.lock {
                presentProgress()
            }
        case .success(let data):
            prepareProgress.unlock {
                dismissProgress()
            }
            consumer(.success(data))
        case .failure(let error):
            prepareProgress.unlock {
                dismissProgress()
            }
            consumer(.failure(error))
        }
    }
}

extension PreparePersonsListPresenter {
    
    private func tellUserInterfaceToPresentViewData(_ viewData: PersonItemsViewData) {
        ui?.present(viewData: viewData)
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

