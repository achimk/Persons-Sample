//
//  CreatePersonScreenViewFactory.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import PersonsFeature

struct CreatePersonScreenViewFactory {
    
    static func create(delegate: SubmitPersonScreenViewDelegate? = nil) -> ScreenType {
        
        let localizer = SubmitPersonScreenViewLocalizer()
        
        let screen = SubmitPersonScreenView()
        screen.title = NSLocalizedString("Create", comment: "")
        screen.module = CreatePersonFeatureFactory.create(localizer: localizer)
        screen.delegate = delegate
        
        return screen
    }
}
