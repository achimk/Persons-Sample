//
//  PersonsListWireframe.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public protocol PersonsListWireframe: class {
    
    func selectedPerson(with context: PersonContext)
}
