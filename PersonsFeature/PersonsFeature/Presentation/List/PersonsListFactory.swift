//
//  PersonsListFactory.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

typealias PersonsConsumer = ([Person]) -> ()

struct PersonsListFactory {
    
    static func create() -> (module: PersonsListModule, consumer: PersonsConsumer) {
        
        fatalError()
    }
}
