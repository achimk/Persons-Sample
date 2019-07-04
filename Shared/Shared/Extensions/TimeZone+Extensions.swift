//
//  TimeZone+Extensions.swift
//  Shared
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

extension TimeZone {
    
    public static var utc: TimeZone { return TimeZone(identifier: "UTC")! }
}
