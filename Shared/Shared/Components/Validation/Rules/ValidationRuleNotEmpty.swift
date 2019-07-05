//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct ValidationRuleNotEmpty<Value: EmptyCheckable, Error>: ValidationRule {
    
    public let error: Error
    
    public init(error: Error) {
        self.error = error
    }
    
    public func validate(_ value: Value?) -> Bool {
        
        guard let value = value else { return false }
        
        return !value.isEmpty
    }
}
