//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct ValidationRuleTextCharacterSet<Error>: ValidationRule {
    
    public let characterSet: CharacterSet
    public let error: Error
    
    public init(characterSet: CharacterSet, error: Error) {
        self.characterSet = characterSet
        self.error = error
    }
    
    public func validate(_ value: String?) -> Bool {
        
        guard let value = value else { return false }
        
        for uni in value.unicodeScalars {
            guard let uniVal = UnicodeScalar(uni.value), characterSet.contains(uniVal) else {
                return false
            }
        }
        
        return true
    }
}
