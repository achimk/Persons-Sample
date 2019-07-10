//
//  PersonsListScreenViewFactory.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import AppCore
import PersonsFeature

struct PersonsListScreenViewFactory {
    
    static func create(with delegate: PersonsListScreenViewDelegate? = nil) -> ScreenType {
        
        let localizer = PersonsListScreenViewLocalizer()
        
        let screen = PersonsListScreenView()
        screen.delegate = delegate
        screen.module = PersonsListFeatureFactory.create(
            with: AppCore.Application.context,
            localizer: localizer)
        
        return screen
    }
}
