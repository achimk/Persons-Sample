//
//  NonEmpty+Extensions.swift
//  Shared
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

extension Validated {
    
    public func mapErrors<ErrorOfResult>(_ transform: (Error) -> ErrorOfResult) -> Validated<Value, ErrorOfResult> {
        switch self {
        case let .valid(value):
            return .valid(value)
        case let .invalid(errors):
            return .invalid(errors.map(transform))
        }
    }
}
