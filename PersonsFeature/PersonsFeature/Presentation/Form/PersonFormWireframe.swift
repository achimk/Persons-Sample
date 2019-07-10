//
//  PersonFormWireframe.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public protocol PersonFormWireframe: class {
    func submitedPerson(with context: PersonContext)
}
