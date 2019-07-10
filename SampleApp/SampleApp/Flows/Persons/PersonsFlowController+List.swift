//
//  PersonsFlowController+List.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import PersonsFeature

extension PersonsFlowController: PersonsListScreenViewDelegate {
    
    func presentList() {
        let screen = PersonsListScreenViewFactory.create(with: self)
        presenter.present(screen)
    }
    
    func personsListScreen(_ screen: PersonsListScreenView, didSelectPerson context: PersonContext) {
        presentUpdateScreen(context: context)
    }
    
    func personsListScreenDidSelectAddPerson(_ screen: PersonsListScreenView) {
        presentCreateScreen()
    }
}
