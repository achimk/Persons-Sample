//
//  UseCase.swift
//  AppCore
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared

// UseCase Factory

public struct UseCase {
    
    public static func authorized() -> Authorized { return Authorized() }
    
    public static func unauthorized() -> Unauthorized { return Unauthorized() }
}

// Authorized

public struct Authorized {
    
    private var debugLogger: DebugLogger?
    private var eventDispatcher: EventDispatcher?
    private var accessTokenRepository: AccessTokenRepository?
    
    fileprivate init() { }
    
    public func usingPrintLogger(prefix msg: String = "") -> Authorized {
        let debug = curry(printDebugEvent)(msg)
        return using(logger: debug)
    }
    
    public func using(logger: DebugLogger?) -> Authorized {
        var container = self
        container.debugLogger = logger
        return container
    }
    
    public func using(eventDispatcher: EventDispatcher?) -> Authorized {
        var container = self
        container.eventDispatcher = eventDispatcher
        return container
    }
    
    public func using(accessTokenRepository: AccessTokenRepository?) -> Authorized {
        var container = self
        container.accessTokenRepository = accessTokenRepository
        return container
    }
    
    public func create<T>(_ f: @escaping (AccessToken, @escaping EventDispatcher) -> Future<T, ApplicationError>) -> Future<T, ApplicationError> {
        return createUseCase(eventDispatcher: eventDispatcher, accessTokenRepository: accessTokenRepository, f)
    }
}

// Unauthorized

public struct Unauthorized {
    
    private var debugLogger: DebugLogger?
    private var eventDispatcher: EventDispatcher?
    
    fileprivate init() { }
    
    public func usingPrintLogger(prefix msg: String = "") -> Unauthorized {
        let debug = curry(printDebugEvent)(msg)
        return using(logger: debug)
    }
    
    public func using(logger: DebugLogger?) -> Unauthorized {
        var container = self
        container.debugLogger = logger
        return container
    }
    
    public func using(eventDispatcher: EventDispatcher?) -> Unauthorized {
        var container = self
        container.eventDispatcher = eventDispatcher
        return container
    }
    
    public func create<T>(_ f: @escaping (@escaping EventDispatcher) -> Future<T, ApplicationError>) -> Future<T, ApplicationError> {
        return createUseCase(eventDispatcher: eventDispatcher, f)
    }
}

// Create UseCase

fileprivate func createUseCase<T>(
    eventDispatcher: EventDispatcher?,
    accessTokenRepository: AccessTokenRepository?,
    _ f: @escaping (AccessToken, @escaping EventDispatcher) -> Future<T, ApplicationError>) -> Future<T, ApplicationError> {
    
    let mainEventDispatcher = eventDispatcher ?? Application.context.eventDispatcher
    let accessTokenRepository = accessTokenRepository ?? Application.context.container.accessTokenRepository
    
    return EventDispatchUseCase(eventDispatcher: mainEventDispatcher, execution: { (eventDispatcher) -> Future<T, ApplicationError> in
        
        return AuthorizedUseCase(accessTokenRepository: accessTokenRepository, eventDispatcher: mainEventDispatcher, execution: { (accessToken) -> Future<T, ApplicationError> in
            
            return f(accessToken, eventDispatcher)
            
        }).prepare()
        
    }).prepare()
}

fileprivate func createUseCase<T>(
    eventDispatcher: EventDispatcher?,
    _ f: @escaping (@escaping EventDispatcher) -> Future<T, ApplicationError>) -> Future<T, ApplicationError> {
    
    let eventDispatcher = eventDispatcher ?? Application.context.eventDispatcher
    
    return EventDispatchUseCase(eventDispatcher: eventDispatcher, execution: { (eventDispatcher) -> Future<T, ApplicationError> in
        
        return f(eventDispatcher)
        
    }).prepare()
}
