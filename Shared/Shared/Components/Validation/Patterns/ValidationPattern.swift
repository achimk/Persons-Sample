//
//  ValidationPattern.swift
//  Shared
//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public protocol ValidationPattern {
    
    var pattern: String { get }
    
    var mask: String? { set get }
    
    var tip: String? { set get }
}
