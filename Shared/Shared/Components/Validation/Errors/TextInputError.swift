//
//  TextInput.swift
//  Shared
//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct TextInput {
    
    public enum Length {
        
        case characters
        case utf8
        case utf16
        case unicodeScalars
        
        public func length(_ value: String) -> Int {
            
            switch self {
            case .characters: return value.count
            case .utf8: return value.utf8.count
            case .utf16: return value.utf16.count
            case .unicodeScalars: return value.unicodeScalars.count
            }
        }
    }
}

public enum TextInputError: Swift.Error {
    
    // General
    case isEmpty
    case textLengthIsLess(than: UInt)
    case textLengthIsGreater(than: UInt)
    case textLengthIsNotEqual(to: UInt)
    case textNotContainNumber
    case textNotContainLowerCase
    case textNotContainUpperCase
    case textNotContainSpecialCharacter
    case textNotOnlyDigits
    case textNotOnlyAlphanumerics
    case textNotOnlyLetters
    case textNotMatchBeginsWith(ValidationPattern)
    case textNotMatchEndsWith(ValidationPattern)
    case textNotMatch(ValidationPattern)
    
    // Patterns
    case invalidEmail
    case invalidURL
}
