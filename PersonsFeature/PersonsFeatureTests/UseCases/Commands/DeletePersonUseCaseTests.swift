//
//  DeletePersonUseCaseTests.swift
//  PersonsFeatureTests
//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import XCTest
import Shared
import AppCore
@testable import PersonsFeature

final class DeletePersonUseCaseTests {
 
    func testDeletePersonSuccess() {

    }
    
    func testDeletePersonFailure() {
        
    }
    
    func testDeletePersonsSuccess() {
        
    }
    
    func testDeletePersonsFailure() {
        
    }
}

extension DeletePersonUseCaseTests {
    
    final class MockDeletePersonGateway: DeletePersonGateway {
        
        private var promise: Promise<NonEmptyArray<PersonId>, ApplicationError>?
        
        func complete(with personIds: NonEmptyArray<PersonId>) {
            promise?.complete(.success(personIds))
            promise = nil
        }
        
        func complete(with error: ApplicationError) {
            promise?.complete(.failure(error))
            promise = nil
        }
        
        func delete(with ids: NonEmptyArray<PersonId>, token: AccessToken) -> Future<NonEmptyArray<PersonId>, ApplicationError> {
            let promise = Promise<NonEmptyArray<PersonId>, ApplicationError>()
            self.promise = promise
            return promise.future
        }
    }
}
