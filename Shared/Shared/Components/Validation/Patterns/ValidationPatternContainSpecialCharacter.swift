//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct ValidationPatternContainSpecialCharacter: ValidationPattern {

    public let pattern: String = "^.*?[#\\$^+=!*()@%&].*?$"
    
    public var mask: String?
    
    public var tip: String?
    
    public init() { }
}

