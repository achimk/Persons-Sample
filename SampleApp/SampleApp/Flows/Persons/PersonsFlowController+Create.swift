//
//  PersonsFlowController+Create.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

extension PersonsFlowController {
    
    func presentCreateScreen() {
        let screen = CreatePersonScreenViewFactory.create(delegate: self)
        presenter.present(screen)
    }
}
