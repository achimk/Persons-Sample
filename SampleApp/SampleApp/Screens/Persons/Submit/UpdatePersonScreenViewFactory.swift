//
//  UpdatePersonScreenViewFactory.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import PersonsFeature

struct UpdatePersonScreenViewFactory {
    
    static func create(delegate: SubmitPersonScreenViewDelegate? = nil, context: PersonContext) -> ScreenType {
        
        let localizer = SubmitPersonScreenViewLocalizer()
        
        let screen = SubmitPersonScreenView()
        screen.title = NSLocalizedString("Update", comment: "")
        screen.module = UpdatePersonFeatureFactory.create(localizer: localizer, context: context)
        screen.delegate = delegate
        
        return screen
    }
}
