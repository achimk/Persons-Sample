//
//  PersonsFlowController+Update.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import PersonsFeature

extension PersonsFlowController {
    
    func presentUpdateScreen(context: PersonContext) {
        let screen = UpdatePersonScreenViewFactory.create(delegate: self, context: context)
        presenter.present(screen)
    }
}
