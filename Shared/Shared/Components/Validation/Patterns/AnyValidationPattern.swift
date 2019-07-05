//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct AnyValidationPattern: ValidationPattern {
    
    public var pattern: String
    public var mask: String?
    public var tip: String?
    
    public init(pattern: String, mask: String? = nil, tip: String? = nil) {
        self.pattern = pattern
        self.mask = mask
        self.tip = tip
    }
}
