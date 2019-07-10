//
//  DeletePersonsListModel.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared
import AppCore
import AdaptersCore

protocol DeletePersonsListModelResponse: class {
    func didUpdate(with state: DataState<NonEmptyArray<PersonId>, ApplicationError>)
}

final class DeletePersonsListModel {
    
    private let provider: PersonsDeleteProvider
    private var store: DataStore<NonEmptyArray<PersonId>, ApplicationError>?
    private var state: DataState<NonEmptyArray<PersonId>, ApplicationError> = .idle {
        didSet { notifyDidUpdate(state: state) }
    }
    
    weak var listener: DeletePersonsListModelResponse?
    
    init(provider: @escaping PersonsDeleteProvider) {
        self.provider = provider
    }
    
    func submit(_ ids: NonEmptyArray<PersonId>) {
        state.onReady {
            store = DataStore { [provider] in provider(ids) }
            store?.subscribe({ [weak self] (oldState, newState) in
                self?.state = newState
            })
            store?.dispatch()
        }
    }
    
    private func notifyDidUpdate(state: DataState<NonEmptyArray<PersonId>, ApplicationError>) {
        listener?.didUpdate(with: state)
    }
}
