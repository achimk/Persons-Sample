//
//  Created by Joachim Kret on 14/05/2019.
//  Copyright © 2019 Enterpryze. All rights reserved.
//

import Foundation

public func with<A, B>(_ a: A, _ f: (A) throws -> B) rethrows -> B {
    
    return try f(a)
}
