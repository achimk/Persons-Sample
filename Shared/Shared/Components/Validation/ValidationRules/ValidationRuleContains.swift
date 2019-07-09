//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct ValidationRuleContains<Container: Sequence, Value: Equatable, Error>: ValidationRule where Container.Element == Value, Error: Swift.Error {
    
    public let error: Error
    public let container: Container
    
    public init(container: Container, error: Error) {
        self.container = container
        self.error = error
    }
    
    public func validate(_ value: Value?) -> Bool {
        guard let value = value else {
            return false
        }
        return container.contains(value)
    }
}
