//
//  CreatePersonUseCaseTests.swift
//  PersonsFeatureTests
//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import XCTest
import Shared
import AppCore
@testable import PersonsFeature

final class CreatePersonUseCaseTests: XCTestCase {
    
    func testCreatePersonSuccess() {
        
        let e = expectation(description: "")
        let eventDispatcher = MockEventDispatcher()
        let data = UnvalidatedPerson(name: "Stephen", surname: "Hawking", email: "stephen.hawking@com.us", age: "76", website: nil)
        let token = "TestAccessToken"
        let gateway = MockCreatePersonGateway()
        
        let useCase = CreatePersonUseCase(data: data, token: token, eventDispatcher: eventDispatcher.dispatch, gateway: gateway)
        gateway.complete(with: PersonId.init(rawValue: "1"))
        
        useCase.prepare().onComplete { (result) in
            XCTAssertTrue(result.isSuccess)
            XCTAssertTrue(eventDispatcher.invokedCreateEvent)
            e.fulfill()
        }

        wait(for: [e], timeout: 1)
    }
    
    func testCreatePersonValidationFailure() {

        let e = expectation(description: "")
        let eventDispatcher = MockEventDispatcher()
        let data = UnvalidatedPerson(name: nil, surname: nil, email: nil, age: nil, website: nil)
        let token = "TestAccessToken"
        let gateway = MockCreatePersonGateway()
        
        let useCase = CreatePersonUseCase(data: data, token: token, eventDispatcher: eventDispatcher.dispatch, gateway: gateway)
        gateway.complete(with: PersonId.init(rawValue: "1"))
        
        useCase.prepare().onComplete { (result) in
            XCTAssertTrue(result.isFailure)
            XCTAssertFalse(eventDispatcher.invokedCreateEvent)
            e.fulfill()
        }
        
        wait(for: [e], timeout: 1)
    }
    
    func testCreatePersonGatewayFailure() {
        
        let e = expectation(description: "")
        let eventDispatcher = MockEventDispatcher()
        let data = UnvalidatedPerson(name: "Stephen", surname: "Hawking", email: "stephen.hawking@com.us", age: "76", website: nil)
        let token = "TestAccessToken"
        let gateway = MockCreatePersonGateway()
        
        let useCase = CreatePersonUseCase(data: data, token: token, eventDispatcher: eventDispatcher.dispatch, gateway: gateway)
        gateway.complete(with: ApplicationError.unexpectedErrorOccurred)
        
        useCase.prepare().onComplete { (result) in
            XCTAssertFalse(result.isSuccess)
            XCTAssertFalse(eventDispatcher.invokedCreateEvent)
            e.fulfill()
        }
        
        wait(for: [e], timeout: 1)
    }
}

extension CreatePersonUseCaseTests {
    
    final class MockCreatePersonGateway: CreatePersonGateway {
        
        private let promise = Promise<PersonId, ApplicationError>()
        
        func complete(with personId: PersonId) {
            promise.complete(.success(personId))
        }
        
        func complete(with error: ApplicationError) {
            promise.complete(.failure(error))
        }
        
        func create(with data: ValidatedPerson, token: AccessToken) -> Future<PersonId, ApplicationError> {
            return promise.future
        }        
    }
}
