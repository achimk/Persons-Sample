//
//  UpdatePersonUseCaseTests.swift
//  PersonsFeatureTests
//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import XCTest
import Shared
import AppCore
@testable import PersonsFeature

final class UpdatePersonUseCaseTests: XCTestCase {
    
    func testUpdatePersonSuccess() {
        
        
    }
    
    func testUpdatePersonFailure() {
        
    }
}

extension UpdatePersonUseCaseTests {
    
    final class MockUpdatePersonGateway: UpdatePersonGateway {
        
        private var promise: Promise<PersonId, ApplicationError>?
        
        func complete(with personId: PersonId) {
            promise?.complete(.success(personId))
            promise = nil
        }
        
        func complete(with error: ApplicationError) {
            promise?.complete(.failure(error))
            promise = nil
        }
        
        func update(with id: PersonId, data: ValidatedPerson, token: AccessToken) -> Future<PersonId, ApplicationError> {
            let promise = Promise<PersonId, ApplicationError>()
            self.promise = promise
            return promise.future
        }
    }

}
