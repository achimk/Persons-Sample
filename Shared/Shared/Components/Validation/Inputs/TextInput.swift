//
//  TextInput.swift
//  Shared
//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct TextInput {
    
    public enum Rule {
        
        // General
        case required
        case notEmpty
        case minLength(UInt)
        case minLengthTyped(UInt, type: Length)
        case maxLength(UInt)
        case maxLengthTyped(UInt, type: Length)
        case equalLength(UInt)
        case equalLengthTyped(UInt, type: Length)
        case containDigit
        case containLowerCase
        case containUpperCase
        case containSpecialCharacter
        case onlyDigits
        case onlyAlphanumerics
        case onlyLetters
        case min(String)
        case max(String)
        case equal(String)
        case beginsWith(ValidationPattern)
        case endsWith(ValidationPattern)
        case regex(ValidationPattern)
        
        // Patterns
        case email
        case url
    }
    
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