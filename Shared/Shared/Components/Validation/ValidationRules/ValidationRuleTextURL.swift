//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct ValidationRuleTextURL<Error>: ValidationRule where Error: Swift.Error {
    
    public let error: Error
    
    public init(error: Error) {
        self.error = error
    }
    
    public func validate(_ value: String?) -> Bool {
        guard let value = value else { return false }
        return URL(string: value) != nil
    }
    
}
