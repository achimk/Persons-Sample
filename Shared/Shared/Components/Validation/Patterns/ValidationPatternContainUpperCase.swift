//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct ValidationPatternContainUpperCase: ValidationPattern {
    
    public let pattern: String = "^.*?[A-Z].*?$"
    
    public var mask: String?
    
    public var tip: String?
    
    public init() { }
}
