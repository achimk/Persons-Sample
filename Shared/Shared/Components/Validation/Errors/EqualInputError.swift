//
//  EqualInput.swift
//  Shared
//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public enum EqualInputError: Swift.Error {
    case isEqual(to: String)
    case isNotEqual(to: String)
}
