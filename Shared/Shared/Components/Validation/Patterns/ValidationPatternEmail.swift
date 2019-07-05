//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct ValidationPatternEmail: ValidationPattern {
    
    public enum Kind: String {
    
        case simple = "^.+@.+\\..+$"
        
        case standard = "^[_A-Za-z0-9-+]+(\\.[_A-Za-z0-9-+]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z‌​]{2,})$"
    }
    
    public var pattern: String
    
    public var mask: String?
    
    public var tip: String?
    
    public static func simple() -> ValidationPatternEmail {
        return ValidationPatternEmail(pattern: Kind.simple.rawValue, mask: nil, tip: nil)
    }
    
    public static func standard() -> ValidationPatternEmail {
        return ValidationPatternEmail(pattern: Kind.standard.rawValue, mask: nil, tip: nil)
    }
}
