//
//  PersonFormModel.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

protocol PersonFormModelResponse: class {
    func didUpdate(unvalidated: UnvalidatedPerson, with invalidData: InvalidPersonData?)
}

final class PersonFormModel {
    
    private var unvalidated = UnvalidatedPerson()
    private var invalidData: InvalidPersonData?
    private let submitter: PersonSubmitter

    weak var listener: PersonFormModelResponse?
    
    init(submitter: @escaping PersonSubmitter) {
        self.submitter = submitter
    }
    
    func update(unvalidated: UnvalidatedPerson) {
        update {
            self.unvalidated = unvalidated
        }
    }
    
    func update(invalidData: InvalidPersonData) {
        update {
            self.invalidData = invalidData
        }
    }
    
    func set(name value: String?) {
        update {
            unvalidated.name = value
            removeError(for: .name)
        }
    }
    
    func set(surname value: String?) {
        update {
            unvalidated.surname = value
            removeError(for: .surname)
        }
    }
    
    func set(email value: String?) {
        update {
            unvalidated.email = value
            removeError(for: .email)
        }
    }
    
    func set(age value: String?) {
        update {
            unvalidated.age = value
            removeError(for: .age)
        }
    }
    
    func set(website value: String?) {
        update {
            unvalidated.website = value
            removeError(for: .website)
        }
    }
    
    func submit() {
        submitter(unvalidated)
    }
    
    private func removeError(for key: InvalidPersonData.Key) {
        invalidData = invalidData?.removed(key)
    }
    
    private func update(_ action: () -> ()) {
        action()
        listener?.didUpdate(unvalidated: unvalidated, with: invalidData)
    }
}
