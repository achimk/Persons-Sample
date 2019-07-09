//
//  ValidationState.swift
//  AdaptersCore
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public enum ValidationState {
    
    case valid
    
    case invalid(message: String)
}

public protocol ValidationStateful {
    var validationState: ValidationState { get }
}

extension ValidationStateful {
    
    public var isValid: Bool {
        if case .valid = validationState { return true }
        return false
    }
    
    public var isInvalid: Bool {
        return !isValid
    }
    
    public var errorMessage: String? {
        if case .invalid(let message) = validationState { return message }
        return nil
    }
}

extension ValidationStateful {
    
    public func onValid(_ action: () -> ()) {
        if isValid { action() }
    }
    
    public func onInvalid(_ action: () -> ()) {
        if isInvalid { action() }
    }
}
