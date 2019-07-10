//
//  PersonsListScreenViewDelegate.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import PersonsFeature

protocol PersonsListScreenViewDelegate: class {
    func personsListScreen(_ screen: PersonsListScreenView, didSelectPerson context: PersonContext)
}
