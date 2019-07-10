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
    
    private let deleteConsumer: PersonsDeleteConsumer
    
    private var state: PersonsListState = .idle {
        didSet { notifyDidUpdate(state) }
    }
    
    weak var listener: PersonsListModelResponse?
    
    init(deleteConsumer: @escaping PersonsDeleteConsumer) {
        self.deleteConsumer = deleteConsumer
    }
    
    func prepare(with result: Result<[Person], ApplicationError>) {
        result.onSuccess { (persons) in
            self.state = .success(persons)
        }
        result.onFailure { error in
            self.state = .failure(error)
        }
    }
    
    func delete(_ person: Person) {
        deleteConsumer(NonEmptyArray(person.id))
    }
    
    private func notifyDidUpdate(_ state: PersonsListState) {
        listener?.didUpdate(with: state)
    }
}
