//
//  PersonsListScreenViewLocalizer.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import AppCore
import PersonsFeature

struct PersonsListScreenViewLocalizer: PersonsListLocalizing {
    
    func localized(applicationError: ApplicationError) -> String {
        return ApplicationErrorLocalizer.localized(applicationError: applicationError)
    }
}
