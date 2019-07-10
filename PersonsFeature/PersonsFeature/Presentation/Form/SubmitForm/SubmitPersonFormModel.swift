//
//  SubmitPersonFormModel.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import AppCore
import AdaptersCore

protocol SubmitPersonFormModelResponse: class {
    func didUpdate(with state: DataState<PersonId, ApplicationError>)
}

final class SubmitPersonFormModel {
    
    private let provider: PersonSubmitProvider
    private var store: DataStore<PersonId, ApplicationError>?
    private var state: DataState<PersonId, ApplicationError> = .idle {
        didSet { notifyDidUpdate(state: state) }
    }
    
    weak var listener: SubmitPersonFormModelResponse?
    
    init(provider: @escaping PersonSubmitProvider) {
        self.provider = provider
    }
    
    func submit(_ unvalidated: UnvalidatedPerson) {
        state.onReady {
            store = DataStore { [provider] in provider(unvalidated) }
            store?.subscribe({ [weak self] (oldState, newState) in
                self?.state = newState
            })
            store?.dispatch()
        }
    }
    
    private func notifyDidUpdate(state: DataState<PersonId, ApplicationError>) {
        listener?.didUpdate(with: state)
    }
}
