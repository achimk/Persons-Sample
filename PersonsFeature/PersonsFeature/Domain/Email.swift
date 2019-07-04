//
//  Email.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

struct Email {
    
    let value: String
    
    init?(_ value: String?) {
        
        guard let value = value else { return nil }
        
        // FIXME: Validate email with rule!
        self.value = value
    }
}
