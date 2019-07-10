//
//  PersonFormLocalizing.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import AdaptersCore

public protocol PersonFormLocalizing: ApplicationErrorLocalizing, ValidationErrorLocalizing {
    
    var localizedNamePlaceholder: String { get }
    
    var localizedSurnamePlaceholder: String { get }
    
    var localizedEmailPlaceholder: String { get }
    
    var localizedAgePlaceholder: String { get }
    
    var localizedWebsitePlaceholder: String { get }
    
    var localizedSubmitActionTitle: String { get }
}
