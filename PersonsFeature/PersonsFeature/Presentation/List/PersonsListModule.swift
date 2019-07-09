//
//  PersonsListModule.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public protocol PersonsListModule {
    
    func attach(_ ui: PersonsListUserInterface, wireframe: PersonsListWireframe)
    
    func detach()
}
