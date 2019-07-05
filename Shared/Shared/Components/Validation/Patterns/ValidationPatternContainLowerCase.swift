//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct ValidationPatternContainLowerCase: ValidationPattern {
    
    public let pattern: String = "^.*?[a-z].*?$"
    
    public var mask: String?
    
    public var tip: String?
    
    public init() { }
}
