//
//  Result.swift
//  Shared
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public enum Result<Success, Failure: Swift.Error> {
    
    case success(Success)
    
    case failure(Failure)
}

extension Result {
    
    public init(_ value: Success) {
        self = .success(value)
    }
    
    public init(_ error: Failure) {
        self = .failure(error)
    }
    
}

extension Result {
    
    public func map<U>(_ f: (Success) -> U) -> Result<U, Failure> {
        return flatMap { .success(f($0)) }
    }
    
    public func mapError<E: Swift.Error>(_ f: (Failure) -> E) -> Result<Success, E> {
        return flatMapError { .failure(f($0)) }
    }
    
    public func flatMap<U>(_ f: (Success) -> Result<U, Failure>) -> Result<U, Failure> {
        return analyze(ifSuccess: f, ifFailure: Result<U, Failure>.failure)
    }
    
    public func flatMapError<E: Swift.Error>(_ f: (Failure) -> Result<Success, E>) -> Result<Success, E> {
        return analyze(ifSuccess: Result<Success, E>.success, ifFailure: f)
    }
}

extension Result {
    
    public var value: Success? { return analyze(ifSuccess: { $0 }, ifFailure: { _ in nil }) }
    
    public var error: Failure? { return analyze(ifSuccess: { _ in nil }, ifFailure: { $0 }) }
    
    public var isSuccess: Bool { return analyze(ifSuccess: { true }, ifFailure: { false }) }
    
    public var isFailure: Bool { return !isSuccess }
    
}

extension Result {
    
    public func onSuccess(_ perform: (Success) -> ()) {
        analyze(ifSuccess: perform, ifFailure: { _ in })
    }
    
    public func onFailure(_ perform: (Failure) -> ()) {
        analyze(ifSuccess: { _ in }, ifFailure: perform)
    }
    
    public func analyze<T>(ifSuccess: () throws -> T, ifFailure: () throws -> T) rethrows -> T {
        switch self {
        case .success: return try ifSuccess()
        case .failure: return try ifFailure()
        }
    }
    
    public func analyze<T>(ifSuccess: (Success) throws -> T, ifFailure: (Failure) throws -> T) rethrows -> T {
        switch self {
        case .success(let value): return try ifSuccess(value)
        case .failure(let error): return try ifFailure(error)
        }
    }
}

extension Result where Success == Void {
    
    public static func success() -> Result<Success, Failure> {
        return Result.success(())
    }
}

extension Result where Failure: Swift.Error {
    
    public func determineValue() throws -> Success {
        switch self {
        case .success(let value): return value
        case .failure(let error): throw error
        }
    }
    
    public func throwsIfFailure() throws {
        switch self {
        case .success: return
        case .failure(let error): throw error
        }
    }
}

extension Result {
    
    public func asEither() -> Either<Failure, Success> {
        
        return analyze(
            ifSuccess: Either<Failure, Success>.right,
            ifFailure: Either<Failure, Success>.left
        )
    }
}
