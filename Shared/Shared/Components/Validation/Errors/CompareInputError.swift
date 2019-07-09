//
//  CompareInput.swift
//  Shared
//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public enum CompareInputError: Swift.Error {
    case isLess(than: String)
    case isLessOrNotEqual(to: String)
    case isGreater(than: String)
    case isGreaterOrNotEqual(to: String)
}
