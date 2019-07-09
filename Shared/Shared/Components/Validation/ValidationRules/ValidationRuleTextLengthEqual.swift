//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct ValidationRuleTextLengthEqual<Error>: ValidationRule where Error: Swift.Error {
    
    public let length: UInt
    public let type: TextInput.Length
    public let error: Error
    
    public init(_ length: UInt = 0,
                type: TextInput.Length = .characters,
                error: Error) {
        
        self.length = length
        self.type = type
        self.error = error
    }
    
    public func validate(_ value: String?) -> Bool {
        guard let value = value else { return false }
        return type.length(value) == length
    }
}


