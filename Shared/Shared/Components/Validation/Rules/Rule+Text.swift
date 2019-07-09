//
//  Rule+Text.swift
//  Shared
//
//  Created by Joachim Kret on 08/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public typealias TextRule = Rule<String>

extension Rule where T == String {
    
    public func notEmpty() -> Rule<String> {
        return apply(ValidationRuleTextNotEmpty(error: TextInputError.isEmpty))
    }
    
    public func minLength(_ length: UInt) -> Rule<String> {
        return apply(ValidationRuleTextLengthMin(
            length,
            type: TextInput.Length.characters,
            error: TextInputError.textLengthIsLess(than: length)))
    }
    
    public func maxLength(_ length: UInt) -> Rule<String> {
        return apply(ValidationRuleTextLengthMax(
            length,
            type: TextInput.Length.characters,
            error: TextInputError.textLengthIsGreater(than: length)))
    }
    
    public func equalLength(_ length: UInt) -> Rule<String> {
        return apply(ValidationRuleTextLengthEqual(
            length,
            type: TextInput.Length.characters,
            error: TextInputError.textLengthIsNotEqual(to: length)))
    }
    
    public func containNumber() -> Rule<String> {
        return apply(ValidationRuleTextPattern(
            pattern: ValidationPatternContainNumber().pattern,
            error: TextInputError.textNotContainNumber))
    }
    
    public func containLowerCase() -> Rule<String> {
        return apply(ValidationRuleTextPattern(
            pattern: ValidationPatternContainLowerCase().pattern,
            error: TextInputError.textNotContainLowerCase))
    }
    
    public func containUpperCase() -> Rule<String> {
        return apply(ValidationRuleTextPattern(
            pattern: ValidationPatternContainUpperCase().pattern,
            error: TextInputError.textNotContainUpperCase))
    }
    
    public func containSpecialCharacter() -> Rule<String> {
        return apply(ValidationRuleTextPattern(
            pattern: ValidationPatternContainSpecialCharacter().pattern,
            error: TextInputError.textNotContainSpecialCharacter))
    }
    
    public func onlyDigits() -> Rule<String> {
        return apply(ValidationRuleTextCharacterSet(
            characterSet: CharacterSet.decimalDigits,
            error: TextInputError.textNotOnlyDigits))
    }
    
    public func onlyAlphanumerics() -> Rule<String> {
        return apply(ValidationRuleTextCharacterSet(
            characterSet: CharacterSet.alphanumerics,
            error: TextInputError.textNotOnlyAlphanumerics))
    }
    
    public func onlyLetters() -> Rule<String> {
        return apply(ValidationRuleTextCharacterSet(
            characterSet: CharacterSet.letters,
            error: TextInputError.textNotOnlyLetters))
    }
    
    public func beginsWith(_ pattern: ValidationPattern) -> Rule<String> {
        return apply(ValidationRuleTextBeginsWith(
            pattern: pattern.pattern,
            error: TextInputError.textNotMatchBeginsWith(pattern)))
    }
    
    public func endsWith(_ pattern: ValidationPattern) -> Rule<String> {
        return apply(ValidationRuleTextEndsWith(
            pattern: pattern.pattern,
            error: TextInputError.textNotMatchEndsWith(pattern)))
    }
    
    public func match(_ pattern: ValidationPattern) -> Rule<String> {
        return apply(ValidationRuleTextPattern(
            pattern: pattern.pattern,
            error: TextInputError.textNotMatch(pattern)))
    }
    
    public func isEmail(_ pattern: ValidationPatternEmail = .standard()) -> Rule<String> {
        return apply(ValidationRuleTextPattern(
            pattern: pattern.pattern,
            error: TextInputError.invalidEmail))
    }
    
    public func isURL() -> Rule<String> {
        return apply(ValidationRuleTextURL(error: TextInputError.invalidURL))
    }
}
