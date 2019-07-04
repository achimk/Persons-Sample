//
//  Either.swift
//  Shared
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public enum Either<Left, Right> {
    
    case left(Left)
    
    case right(Right)
    
    public init(_ value: Left) {
        self = .left(value)
    }
    
    public init(_ value: Right) {
        self = .right(value)
    }
    
}

extension Either {
    
    public var left: Left? { return analyze(ifLeft: { $0 }, ifRight: { _ in nil }) }
    
    public var right: Right? { return analyze(ifLeft: { _ in nil}, ifRight: { $0 }) }
    
}

extension Either {
    
    public func map<U>(_ f: (Right) -> U) -> Either<Left, U> {
        return flatMap { .right(f($0)) }
    }
    
    public func flatMap<U>(_ f: (Right) -> Either<Left, U>) -> Either<Left, U> {
        return analyze(
            ifLeft: Either<Left, U>.left,
            ifRight: f
        )
    }
    
    public func mapLeft<U>(_ f: (Left) -> U) -> Either<U, Right> {
        return flatMapLeft { .left(f($0)) }
    }
    
    public func flatMapLeft<U>(_ f: (Left) -> Either<U, Right>) -> Either<U, Right> {
        return analyze(
            ifLeft: f,
            ifRight: Either<U, Right>.right
        )
    }
    
    public func onLeft(_ perform: (Left) -> ()) {
        analyze(ifLeft: perform, ifRight: { _ in })
    }
    
    public func onRight(_ perform: (Right) -> ()) {
        analyze(ifLeft: { _ in }, ifRight: perform)
    }
    
    public func analyze<T>(ifLeft: (Left) -> T, ifRight: (Right) -> T) -> T {
        switch self {
        case let .left(value): return ifLeft(value)
        case let .right(value): return ifRight(value)
        }
    }
}

extension Either where Left: Swift.Error {
    
    public func asResult() -> Result<Right, Left> {
        
        return analyze(
            ifLeft: Result<Right, Left>.failure,
            ifRight: Result<Right, Left>.success
        )
    }
}

