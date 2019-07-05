//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct ValidationRuleEqual<Value: Equatable, Error>: ValidationRule {
    
    public let dynamicTarget: () -> Value?
    public let error: Error
    
    public init(target: Value, error: Error) {
        self.dynamicTarget = { target }
        self.error = error
    }
    
    public init(dynamicTarget: @escaping () -> Value?, error: Error) {
        self.dynamicTarget = dynamicTarget
        self.error = error
    }
    
    public func validate(_ value: Value?) -> Bool {
        return value == dynamicTarget()
    }
}
