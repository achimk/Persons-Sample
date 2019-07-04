//
//  DateFormatter+Extensions.swift
//  Shared
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    public func string(from date: Date?) -> String? {
        
        guard let date = date else { return nil }
        
        let formatted = self.string(from: date)
        
        return formatted
    }
}

extension DateFormatter {
    
    public static let iso8601: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter
    }()
    
}

