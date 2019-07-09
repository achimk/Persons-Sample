//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct ValidationRuleTextPattern<Error>: ValidationRule where Error: Swift.Error {
    
    public let pattern: String
    public let error: Error
    
    public init(pattern: String, error: Error) {
        self.pattern = pattern
        self.error = error
    }
    
    public func validate(_ value: String?) -> Bool {
        guard let value = value else { return false }
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: value)
    }
}
