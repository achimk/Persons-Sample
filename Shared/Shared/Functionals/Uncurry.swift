//
//  Created by Joachim Kret on 14/05/2019.
//  Copyright © 2019 Enterpryze. All rights reserved.
//

import Foundation

// MARK: Uncurry

public func uncurry<A, B, C>(_ function: @escaping (A) -> (B) -> C) -> (A, B) -> C {
    
        return { (a: A, b: B) -> C in
            
            function(a)(b)
        }
}

public func uncurry<A, B, C, D>(_ function: @escaping (A) -> (B) -> (C) -> D) -> (A, B, C) -> D {
    
        return { (a: A, b: B, c: C) -> D in
            
            function(a)(b)(c)
        }
}

public func uncurry<A, B, C, D, E>(_ function: @escaping (A) -> (B) -> (C) -> (D) -> E) -> (A, B, C, D) -> E {
    
        return { (a: A, b: B, c: C, d: D) -> E in
            
            function(a)(b)(c)(d)
        }
}

public func uncurry<A, B, C, D, E, F>(_ function: @escaping (A) -> (B) -> (C) -> (D) -> (E) -> F) -> (A, B, C, D, E) -> F {
    
        return { (a: A, b: B, c: C, d: D, e: E) -> F in
            
            function(a)(b)(c)(d)(e)
        }
}

public func uncurry<A, B, C, D, E, F, G>(_ function: @escaping (A) -> (B) -> (C) -> (D) -> (E) -> (F) ->  G) -> (A, B, C, D, E, F) -> G {
    
        return { (a: A, b: B, c: C, d: D, e: E, f: F) -> G in
            
            function(a)(b)(c)(d)(e)(f)
        }
}

// MARK: Uncurry + Throws

public func uncurry<A, B, C>(_ function: @escaping (A) -> (B) throws -> C) -> (A, B) throws -> C {
    
        return { (a: A, b: B) throws -> C in
            
            try function(a)(b)
        }
}

public func uncurry<A, B, C, D>(_ function: @escaping (A) -> (B) -> (C) throws -> D) -> (A, B, C) throws -> D {
    
        return { (a: A, b: B, c: C) throws -> D in
            
            try function(a)(b)(c)
        }
}

public func uncurry<A, B, C, D, E>(_ function: @escaping (A) -> (B) -> (C) -> (D) throws -> E) -> (A, B, C, D) throws -> E {
    
        return { (a: A, b: B, c: C, d: D) throws -> E in
            
            try function(a)(b)(c)(d)
        }
}

public func uncurry<A, B, C, D, E, F>(_ function: @escaping (A) -> (B) -> (C) -> (D) -> (E) throws ->  F) -> (A, B, C, D, E) throws -> F {
    
        return { (a: A, b: B, c: C, d: D, e: E) throws -> F in
            
            try function(a)(b)(c)(d)(e)
        }
}

public func uncurry<A, B, C, D, E, F, G>(_ function: @escaping (A) -> (B) -> (C) -> (D) -> (E) -> (F) throws ->  G) -> (A, B, C, D, E, F) throws -> G {
    
        return { (a: A, b: B, c: C, d: D, e: E, f: F) throws -> G in
            
            try function(a)(b)(c)(d)(e)(f)
        }
}
