//
//  Decimal+Extensions.swift
//  Shared
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

extension Decimal {
    
    public func round(scale: Int, mode: RoundingMode) -> Decimal {
        var value = self
        var result = value
        NSDecimalRound(&result, &value, scale, mode)
        return result
    }
}
