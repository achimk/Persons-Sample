//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct ValidationRuleRequired<Value, Error>: ValidationRule {
    
    public let error: Error
    
    public init(error: Error) {
        self.error = error
    }
    
    public func validate(_ value: Value?) -> Bool {
        return value != nil
    }
}
