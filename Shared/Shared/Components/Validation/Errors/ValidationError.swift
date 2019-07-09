//
//  ValidationError.swift
//  Shared
//
//  Created by Joachim Kret on 08/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public enum ValidationError: Swift.Error {
    case isRequired
    case text(TextInputError)
    case compare(CompareInputError)
    case equal(EqualInputError)
    case other(Swift.Error)
    
    static func from(_ error: Swift.Error) -> ValidationError {
        switch error {
        case let error as TextInputError: return .text(error)
        case let error as CompareInputError: return .compare(error)
        case let error as EqualInputError: return .equal(error)
        case let error as ValidationError: return .from(error)
        default: return .other(error)
        }
    }
}
