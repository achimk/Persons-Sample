//
//  SubmitPersonScreenViewLocalizer.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared
import AppCore
import PersonsFeature

struct SubmitPersonScreenViewLocalizer: PersonFormLocalizing {
    
    var localizedNamePlaceholder: String {
        return NSLocalizedString("Name", comment: "")
    }
    
    var localizedSurnamePlaceholder: String {
        return NSLocalizedString("Surname", comment: "")
    }
    
    var localizedEmailPlaceholder: String {
        return NSLocalizedString("Email", comment: "")
    }
    
    var localizedAgePlaceholder: String {
        return NSLocalizedString("Age", comment: "")
    }
    
    var localizedWebsitePlaceholder: String {
        return NSLocalizedString("Website", comment: "")
    }
    
    var localizedSubmitActionTitle: String {
        return NSLocalizedString("Submit", comment: "")
    }
    
    func localized(applicationError: ApplicationError) -> String {
        return ApplicationErrorLocalizer.localized(applicationError: applicationError)
    }
    
    func localized(validationError: ValidationError) -> String {
        return ValidationErrorLocalizer.localized(validationError: validationError)
    }
    
    
}
