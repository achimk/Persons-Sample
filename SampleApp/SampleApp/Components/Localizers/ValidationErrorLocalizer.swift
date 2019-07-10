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
        // FIXME: Implement
        return NSLocalizedString("Validation error!", comment: "")
    }
}
