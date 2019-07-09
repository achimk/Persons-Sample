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
        
        let e = expectation(description: "")
        let id = PersonId.init(rawValue: "1")
        let eventDispatcher = MockEventDispatcher()
        let data = UnvalidatedPerson(name: "Stephen", surname: "Hawking", email: "stephen.hawking@com.us", age: "76", website: nil)
        let token = "TestAccessToken"
        let gateway = MockUpdatePersonGateway()
        
        let useCase = UpdatePersonUseCase(id: id, data: data, token: token, eventDispatcher: eventDispatcher.dispatch, gateway: gateway)
        gateway.complete(with: id)
        
        useCase.prepare().onComplete { (result) in
            XCTAssertTrue(result.isSuccess)
            XCTAssertTrue(eventDispatcher.invokedUpdateEvent)
            e.fulfill()
        }
        
        wait(for: [e], timeout: 1)
    }
    
    func testUpdatePersonValidationFailure() {
        
        let e = expectation(description: "")
        let id = PersonId.init(rawValue: "1")
        let eventDispatcher = MockEventDispatcher()
        let data = UnvalidatedPerson(name: nil, surname: nil, email: nil, age: nil, website: nil)
        let token = "TestAccessToken"
        let gateway = MockUpdatePersonGateway()
        
        let useCase = UpdatePersonUseCase(id: id, data: data, token: token, eventDispatcher: eventDispatcher.dispatch, gateway: gateway)
        gateway.complete(with: id)
        
        useCase.prepare().onComplete { (result) in
            XCTAssertTrue(result.isFailure)
            XCTAssertFalse(eventDispatcher.invokedUpdateEvent)
            e.fulfill()
        }
        
        wait(for: [e], timeout: 1)
    }
    
    func testUpdatePersonGatewayFailure() {
        
        let e = expectation(description: "")
        let id = PersonId.init(rawValue: "1")
        let eventDispatcher = MockEventDispatcher()
        let data = UnvalidatedPerson(name: "Stephen", surname: "Hawking", email: "stephen.hawking@com.us", age: "76", website: nil)
        let token = "TestAccessToken"
        let gateway = MockUpdatePersonGateway()
        
        let useCase = UpdatePersonUseCase(id: id, data: data, token: token, eventDispatcher: eventDispatcher.dispatch, gateway: gateway)
        gateway.complete(with: ApplicationError.unexpectedErrorOccurred)
        
        useCase.prepare().onComplete { (result) in
            XCTAssertTrue(result.isFailure)
            XCTAssertFalse(eventDispatcher.invokedUpdateEvent)
            e.fulfill()
        }
        
        wait(for: [e], timeout: 1)
    }
}

extension UpdatePersonUseCaseTests {
    
    final class MockUpdatePersonGateway: UpdatePersonGateway {
        
        private let promise = Promise<PersonId, ApplicationError>()
        
        func complete(with personId: PersonId) {
            promise.complete(.success(personId))
        }
        
        func complete(with error: ApplicationError) {
            promise.complete(.failure(error))
        }
        
        func update(with id: PersonId, data: ValidatedPerson, token: AccessToken) -> Future<PersonId, ApplicationError> {
            return promise.future
        }
    }

}
