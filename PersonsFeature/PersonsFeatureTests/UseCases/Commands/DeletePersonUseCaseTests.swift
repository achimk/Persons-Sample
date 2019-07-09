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

final class DeletePersonUseCaseTests: XCTestCase {
 
    func testDeletePersonsSuccess() {
        
        let e = expectation(description: "")
        let id = PersonId.init(rawValue: "1")
        let eventDispatcher = MockEventDispatcher()
        let token = "TestAccessToken"
        let gateway = MockDeletePersonGateway()
        
        let useCase = DeletePersonUseCase(ids: NonEmptyArray(id), token: token, eventDispatcher: eventDispatcher.dispatch, gateway: gateway)
        gateway.complete(with: NonEmptyArray(id))
        
        useCase.prepare().onComplete { (result) in
            XCTAssertTrue(result.isSuccess)
            XCTAssertTrue(eventDispatcher.invokedDeleteEvent)
            e.fulfill()
        }
        
        wait(for: [e], timeout: 1)
    }
    
    func testDeletePersonsGatewayFailure() {
        
        let e = expectation(description: "")
        let id = PersonId.init(rawValue: "1")
        let eventDispatcher = MockEventDispatcher()
        let token = "TestAccessToken"
        let gateway = MockDeletePersonGateway()
        
        let useCase = DeletePersonUseCase(ids: NonEmptyArray(id), token: token, eventDispatcher: eventDispatcher.dispatch, gateway: gateway)
        gateway.complete(with: ApplicationError.unexpectedErrorOccurred)
        
        useCase.prepare().onComplete { (result) in
            XCTAssertTrue(result.isFailure)
            XCTAssertFalse(eventDispatcher.invokedDeleteEvent)
            e.fulfill()
        }
        
        wait(for: [e], timeout: 1)
    }
}

extension DeletePersonUseCaseTests {
    
    final class MockDeletePersonGateway: DeletePersonGateway {
        
        private let promise = Promise<NonEmptyArray<PersonId>, ApplicationError>()
        
        func complete(with personIds: NonEmptyArray<PersonId>) {
            promise.complete(.success(personIds))
        }
        
        func complete(with error: ApplicationError) {
            promise.complete(.failure(error))
        }
        
        func delete(with ids: NonEmptyArray<PersonId>, token: AccessToken) -> Future<NonEmptyArray<PersonId>, ApplicationError> {
            return promise.future
        }
    }
}
