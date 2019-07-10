//
//  ValidationErrorLocalizing.swift
//  AdaptersCore
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared

public protocol ValidationErrorLocalizing {
    func localized(validationError: ValidationError) -> String
}
