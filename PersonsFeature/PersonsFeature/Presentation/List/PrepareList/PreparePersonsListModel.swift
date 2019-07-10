//
//  PreparePersonsListModel.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import AppCore
import AdaptersCore
import Shared

typealias PreparePersonsListState = DataState<[Person], ApplicationError>

protocol PreparePersonsListModelResponse: class {
    func didUpdate(with state: PreparePersonsListState)
}

final class PreparePersonsListModel: EventListener {
    
    private let dataStore: DataStore<[Person], ApplicationError>

    weak var listener: PreparePersonsListModelResponse?
    
    init(provider: @escaping PersonsListProvider) {
        dataStore = DataStore(provider)
        dataStore.subscribe { [weak self] (oldState, newState) in
            self?.notifyDidUpdate(newState)
        }
    }
    
    deinit {
        dataStore.unsubscribe()
    }
    
    func prepare() {
        dataStore.dispatch()
    }
    
    func handle(_ event: Event) {
        if let event = event as? PersonEvent {
            handle(event)
        }
    }
    
    private func handle(_ event: PersonEvent) {
        switch event {
        case .created,
             .updated,
             .deleted: prepare()
        }
    }
    
    private func notifyDidUpdate(_ state: PreparePersonsListState) {
        listener?.didUpdate(with: state)
    }
}
