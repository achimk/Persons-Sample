//
//  DataState.swift
//  AdaptersCore
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared

public enum DataState<Success, Failure: Swift.Error> {
    
    case idle
    
    case processing(Success?)
    
    case success(Success)
    
    case failure(Failure)
    
    public init() { self = .idle }
}

extension DataState {
    
    public var value: Success? {
        if case .success(let value) = self { return value }
        return nil
    }
    
    public var error: Failure? {
        if case .failure(let errorReason) = self { return errorReason }
        return nil
    }
}

extension DataState {
    
    public func map<T>(_ f: (Success) -> T) -> DataState<T, Failure> {
        switch self {
        case .idle: return .idle
        case .processing(let data): return .processing(data.map(f))
        case .failure(let errorReason): return .failure(errorReason)
        case .success(let data): return .success(f(data))
        }
    }
    
    public func mapError<E: Swift.Error>(_ f: (Failure) -> E) -> DataState<Success, E> {
        switch self {
        case .idle: return .idle
        case .processing(let data): return .processing(data)
        case .failure(let errorReason): return .failure(f(errorReason))
        case .success(let data): return .success(data)
        }
    }
}

extension DataState {
    
    public var isIdle: Bool {
        if case .idle = self { return true }
        else { return false }
    }
    
    public var isProcessing: Bool {
        if case .processing = self { return true }
        else { return false }
    }
    
    public var isSuccess: Bool {
        if case .success = self { return true }
        else { return false }
    }
    
    public var isFailure: Bool {
        if case .failure = self { return true }
        else { return false }
    }
}

extension DataState {
    
    public func onReady(_ action: () -> ()) {
        if case .processing = self { return }
        action()
    }
    
    public func onIdle(_ action: () -> ()) {
        if case .idle = self { action() }
    }
    
    public func onProgress(_ action: (Success?) -> ()) {
        if case .processing(let data) = self {
            action(data)
        }
    }
    
    public func onSuccess(_ action: (Success) -> ()) {
        if case .success(let data) = self {
            action(data)
        }
    }
    
    public func onFailure(_ action: (Failure) -> ()) {
        if case .failure(let errorReason) = self {
            action(errorReason)
        }
    }
    
    public func onResult(_ action: (Result<Success, Failure>) -> ()) {
        onSuccess { action(.success($0)) }
        onFailure { action(.failure($0)) }
    }
}

extension DataState {
    
    public func asResult() -> Result<Success, Failure>? {
        var result: Result<Success, Failure>?
        onResult { result = $0 }
        return result
    }
}
