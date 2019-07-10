//
//  ValidationErrorLocalizer.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared

struct ValidationErrorLocalizer {
    
    static func localized(validationError: ValidationError, onOther action: ((Swift.Error) -> String)? = nil) -> String {
        switch validationError {
        case .isRequired:
            return NSLocalizedString("Is required", comment: "")
        case .text(let error):
            return localized(textInputError: error)
        case .compare(let error):
            return localized(compareInputError: error)
        case .equal(let error):
            return localized(equalInputError: error)
        case .other(let error):
            if let action = action { return action(error) }
            else { return NSLocalizedString("Invalid data", comment: "") }
        }
    }
    
    static func localized(textInputError: TextInputError) -> String {
        switch textInputError {
        case .isEmpty:
            return NSLocalizedString("Is empty", comment: "")
        case .textLengthIsLess(let than):
            return NSLocalizedString("Text lenght is less than \(than)", comment: "")
        case .textLengthIsGreater(let than):
            return NSLocalizedString("Text length is greater than \(than)", comment: "")
        case .textLengthIsNotEqual(let to):
            return NSLocalizedString("Text length is not equal to \(to)", comment: "")
        case .textNotContainNumber:
            return NSLocalizedString("Text not contain number", comment: "")
        case .textNotContainLowerCase:
            return NSLocalizedString("Text not contain lower case", comment: "")
        case .textNotContainUpperCase:
            return NSLocalizedString("Text not contain upper case", comment: "")
        case .textNotContainSpecialCharacter:
            return NSLocalizedString("Text not contain special character", comment: "")
        case .textNotOnlyDigits:
            return NSLocalizedString("Text should contain only digits", comment: "")
        case .textNotOnlyAlphanumerics:
            return NSLocalizedString("Text should contain only alpha numerics", comment: "")
        case .textNotOnlyLetters:
            return NSLocalizedString("Text should contain only letters", comment: "")
        case .textNotMatchBeginsWith(let pattern):
            return pattern.tip ?? NSLocalizedString("Invalid begins pattern: \(pattern.pattern)", comment: "")
        case .textNotMatchEndsWith(let pattern):
            return pattern.tip ?? NSLocalizedString("Invalid ends pattern: \(pattern.pattern)", comment: "")
        case .textNotMatch(let pattern):
            return pattern.tip ?? NSLocalizedString("Invalid match pattern: \(pattern.pattern)", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Invalid email", comment: "")
        case .invalidURL:
            return NSLocalizedString("Invalid url", comment: "")
        }
    }
    
    static func localized(compareInputError: CompareInputError) -> String {
        switch compareInputError {
        case .isGreater(let than):
            return NSLocalizedString("Is greater than \(than)", comment: "")
        case .isGreaterOrNotEqual(let to):
            return NSLocalizedString("Is greater or not equal to \(to)", comment: "")
        case .isLess(let than):
            return NSLocalizedString("Is less than \(than)", comment: "")
        case .isLessOrNotEqual(let to):
            return NSLocalizedString("Is less or not equal to \(to)", comment: "")
        }
    }
    
    static func localized(equalInputError: EqualInputError) -> String {
        switch equalInputError {
        case .isEqual(let to):
            return NSLocalizedString("Is equal to \(to)", comment: "")
        case .isNotEqual(let to):
            return NSLocalizedString("Is not equal to \(to)", comment: "")
        }
    }
}
