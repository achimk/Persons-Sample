//
//  UseCaseTests.swift
//  AppCoreTests
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import XCTest
import Shared
import AppCore

final class UseCaseTests: XCTestCase {
    
    func testCallAuthorizedUseCaseWhenAllParametersValid() {
        
        let e = expectation(description: "")
        let eventDispatcher = MockedEventDispatcher()
        let accessTokenRepository = MockedAccessTokenRepository.authenticated()
        
        let future = UseCase
            .authorized()
            .usingPrintLogger()
            .using(eventDispatcher: eventDispatcher.dispatch)
            .using(accessTokenRepository: accessTokenRepository)
            .create { (token, eventDispatcher) in
                TestUseCase(.success(1), eventDispatcher).prepare()
            }
        
        future.onComplete { (result) in
            
            XCTAssertTrue(result.isSuccess)
            
            result.onSuccess({ (value) in
                
                XCTAssertEqual(value, 1)
            })
            
            XCTAssertEqual(eventDispatcher.events.count, 1)
            
            eventDispatcher.events.first.ifPresent({ (event) in
                XCTAssertNotNil(event as? TestEvent)
            })
            
            XCTAssertTrue(accessTokenRepository.isAuthenticated)
            
            e.fulfill()
        }
        
        wait(for: [e], timeout: 1)
    }
    
    func testCallAuthorizedUseCaseWhenUnauthorized() {
        
        let e = expectation(description: "")
        let eventDispatcher = MockedEventDispatcher()
        let accessTokenRepository = MockedAccessTokenRepository.unauthenticated()
        
        let future = UseCase
            .authorized()
            .usingPrintLogger()
            .using(eventDispatcher: eventDispatcher.dispatch)
            .using(accessTokenRepository: accessTokenRepository)
            .create { (token, eventDispatcher) in
                TestUseCase(.success(1), eventDispatcher).prepare()
        }
        
        future.onComplete { (result) in
            
            XCTAssertTrue(result.isFailure)
            
            XCTAssertEqual(eventDispatcher.events.count, 0)
            
            result.onFailure({ (error) in
                if case ApplicationError.accessDenied = error {
                    XCTAssertFalse(accessTokenRepository.isAuthenticated)
                } else {
                    XCTFail("Should never happen!")
                }
            })
            
            e.fulfill()
        }
        
        wait(for: [e], timeout: 1)
    }
    
    func testCallAuthorizedUseCaseWhenAccessRevoked() {
        
        let e = expectation(description: "")
        let eventDispatcher = MockedEventDispatcher()
        let accessTokenRepository = MockedAccessTokenRepository.authenticated()
        
        let future = UseCase
            .authorized()
            .usingPrintLogger()
            .using(eventDispatcher: eventDispatcher.dispatch)
            .using(accessTokenRepository: accessTokenRepository)
            .create { (token, eventDispatcher) in
                TestUseCase(Result<Int, ApplicationError>.failure(.accessRevoked), eventDispatcher).prepare()
        }
        
        future.onComplete { (result) in
            
            XCTAssertTrue(result.isFailure)
            
            XCTAssertEqual(eventDispatcher.events.count, 1)
            
            eventDispatcher.events.first.ifPresent({ (event) in
                if case AccessEvent.authenticationRevoked = event {
                    // noop
                } else {
                    XCTFail("Should never happen!")
                }
            })
            
            result.onFailure({ (error) in
                if case ApplicationError.accessRevoked = error {
                    XCTAssertFalse(accessTokenRepository.isAuthenticated)
                } else {
                    XCTFail("Should never happen!")
                }
            })
            
            e.fulfill()
        }
        
        wait(for: [e], timeout: 1)
    }
    
    func testCallUnauthorizedUseCase() {
        
        let e = expectation(description: "")
        let eventDispatcher = MockedEventDispatcher()
        
        let future = UseCase
            .unauthorized()
            .usingPrintLogger()
            .using(eventDispatcher: eventDispatcher.dispatch)
            .create { (eventDispatcher) in
                TestUseCase(.success(1), eventDispatcher).prepare()
            }
        
        future.onComplete { (result) in

            XCTAssertTrue(result.isSuccess)
            
            result.onSuccess({ (value) in
                
                XCTAssertEqual(value, 1)
            })
            
            XCTAssertEqual(eventDispatcher.events.count, 1)
            
            eventDispatcher.events.first.ifPresent({ (event) in
                XCTAssertNotNil(event as? TestEvent)
            })
            
            e.fulfill()
        }
        
        wait(for: [e], timeout: 1)
    }
}

extension UseCaseTests {
    
    final class MockedEventDispatcher {
        var events: [Event] = []
        
        func dispatch(_ event: Event) {
            events.append(event)
        }
    }

    final class MockedAccessTokenRepository: AccessTokenRepository {
        
        var token: AccessToken?
        
        static func authenticated(with token: String = "test") -> MockedAccessTokenRepository {
            return MockedAccessTokenRepository(token)
        }
        
        static func unauthenticated() -> MockedAccessTokenRepository {
            return MockedAccessTokenRepository(nil)
        }
        
        var isAuthenticated: Bool { return token != nil }
        
        private init(_ token: AccessToken?) {
            self.token = token
        }
        
        func load() -> AccessToken? {
            return token
        }
        
        func save(_ accessToken: AccessToken?) {
            self.token = accessToken
        }
    }
    
    struct TestEvent: Event { }
    
    final class TestUseCase<T> {
        
        private(set) var invokedPrepare: Bool = false
        private(set) var result: Result<T, ApplicationError>
        private let eventDispatcher: EventDispatcher?
        
        init(_ result: Result<T, ApplicationError>, _ eventDispatcher: EventDispatcher? = nil) {
            self.result = result
            self.eventDispatcher = eventDispatcher
        }
        
        func prepare() -> Future<T, ApplicationError> {
            invokedPrepare = true
            let eventDispatcher = self.eventDispatcher
            return Future.init(result: result).andThen(callback: { (result) in
                result.onSuccess { _ in eventDispatcher?(TestEvent()) }
            })
        }
    }
}
