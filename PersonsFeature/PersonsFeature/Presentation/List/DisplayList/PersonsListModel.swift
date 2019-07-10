//
//  PersonsListModel.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import AppCore
import AdaptersCore
import Shared

typealias PersonsListState = DataState<[Person], ApplicationError>

protocol PersonsListModelResponse: class {
    func didUpdate(with state: PersonsListState)
}

final class PersonsListModel {
    
    private var state: PersonsListState = .idle {
        didSet { notifyDidUpdate(state) }
    }
    
    weak var listener: PersonsListModelResponse?
    
    func prepare(with result: Result<[Person], ApplicationError>) {
        result.onSuccess { (persons) in
            self.state = .success(persons)
        }
        result.onFailure { error in
            self.state = .failure(error)
        }
    }
    
    private func notifyDidUpdate(_ state: PersonsListState) {
        listener?.didUpdate(with: state)
    }
}
