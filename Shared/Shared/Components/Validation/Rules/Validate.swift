//
//  Validate.swift
//  Shared
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public func validOn<T, V, E>(nil input: T?, otherwise validate: (T) -> Validated<V, E>) -> Validated<V?, E> {
    switch input {
    case .none: return .valid(nil)
    case .some(let value): return validate(value).map { $0 }
    }
}

public func validOn<T: EmptyCheckable, V, E>(empty input: T?, otherwise validate: (T) -> Validated<V, E>) -> Validated<V?, E> {
    switch input {
    case .none: return .valid(nil)
    case .some(let value):
        return value.isEmpty ? .valid(nil) : validate(value).map { $0 }
    }
    
}
