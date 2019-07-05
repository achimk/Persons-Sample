//
//  AnyInput.swift
//  Shared
//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct AnyInput {
    
    public enum Rule {
        case required
    }
    
    public enum Error: Swift.Error {
        case isRequired
    }
}
