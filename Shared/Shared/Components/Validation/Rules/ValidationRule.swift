//
//  ValidationRule.swift
//  Shared
//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public protocol ValidationRule {
    associatedtype Value
    associatedtype Error
    
    var error: Error { get }
    
    func validate(_ value: Value?) -> Bool
}
