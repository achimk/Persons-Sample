//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct ValidationRuleTextNotEmpty<Error>: ValidationRule {
    
    public let error: Error
    
    public init(error: Error) {
        self.error = error
    }
    
    public func validate(_ value: String?) -> Bool {
        guard let value = value else { return false }
        let set = CharacterSet.whitespacesAndNewlines
        let trimmed = value.trimmingCharacters(in: set)
        return !trimmed.isEmpty
    }
}


