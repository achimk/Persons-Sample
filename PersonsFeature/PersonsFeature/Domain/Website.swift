//
//  Website.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared

struct Website {
    
    var url: URL
    
    private init(_ input: URL) {
        self.url = input
    }
    
    static func create(_ input: URL?) -> Validated<Website, ValidationError> {
        return Rule<URL>
            .create()
            .validate(input)
            .map { Website($0) }
    }
    
    static func create(_ input: String?) -> Validated<Website, ValidationError> {
        return TextRule
            .create()
            .isURL()
            .validate(input)
            .flatMap { create(URL(string: $0)) }
    }
}
