//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct ValidationRuleTextURL<Error>: ValidationRule where Error: Swift.Error {
    
    private let urlRegEx = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
    
    public let error: Error
    
    public init(error: Error) {
        self.error = error
    }
    
    public func validate(_ value: String?) -> Bool {
        guard let value = value else { return false }
        let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
        return urlTest.evaluate(with: value)
    }
    
}
