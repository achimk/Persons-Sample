//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct ValidationRuleCondition<Value, Error>: ValidationRule {
    
    public let error: Error
    public let condition: (Value?) -> Bool
    
    public init(error: Error, condition: @escaping (Value?) -> Bool) {
        self.error = error
        self.condition = condition
    }
    
    public func validate(_ value: Value?) -> Bool {
        return condition(value)
    }
}
