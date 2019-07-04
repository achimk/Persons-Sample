//
//  Created by Joachim Kret on 14/05/2019.
//  Copyright © 2019 Enterpryze. All rights reserved.
//

import Foundation

// MARK: Map

public func map<A, B>(_ transform: @escaping (A) -> B) -> (A?) -> B? {
        
    return { $0.map(transform) }
}

public func map<A, B>(_ transform: @escaping (A) throws -> B) -> (A?) throws -> B? {
        
    return { try $0.map(transform) }
}

// MARK: Zip

public func zip<A, B>(_ a: A?, _ b: B?) -> (A, B)? {

    guard let a = a, let b = b else { return nil }
    
    return (a, b)
}

public func zip<A, B, C>(_ a: A?, _ b: B?, _ c: C?) -> (A, B, C)? {
    
    return zip(zip(a, b), c).map { ($0.0, $0.1, $1) }
}

public func zip<A, B, C, D>(_ a: A?, _ b: B?, _ c: C?, _ d: D?) -> (A, B, C, D)? {
    
    return zip(zip(a, b), c, d).map { ($0.0, $0.1, $1, $2) }
}

public func zip<A, B, C, D, E>(_ a: A?, _ b: B?, _ c: C?, _ d: D?, _ e: E?) -> (A, B, C, D, E)? {
    
    return zip(zip(a, b), c, d, e).map { ($0.0, $0.1, $1, $2, $3) }
}

public func zip<A, B, C, D, E, F>(_ a: A?, _ b: B?, _ c: C?, _ d: D?, _ e: E?, _ f: F?) -> (A, B, C, D, E, F)? {
    
    return zip(zip(a, b), c, d, e, f).map { ($0.0, $0.1, $1, $2, $3, $4) }
}

public func zip<A, B, C, D, E, F, G>(_ a: A?, _ b: B?, _ c: C?, _ d: D?, _ e: E?, _ f: F?, _ g: G?) -> (A, B, C, D, E, F, G)? {
    
    return zip(zip(a, b), c, d, e, f, g).map { ($0.0, $0.1, $1, $2, $3, $4, $5) }
}

// MARK: Zip + Transform

public func zip<A, B, C>(with transform: @escaping (A, B) -> C) -> (A?, B?) -> C? {
    
    return { zip($0, $1).map(transform) }
}

public func zip<A, B, C, D>(with transform: @escaping (A, B, C) -> D) -> (A?, B?, C?) -> D? {
    
    return { zip($0, $1, $2).map(transform) }
}

public func zip<A, B, C, D, E>(with transform: @escaping (A, B, C, D) -> E) -> (A?, B?, C?, D?) -> E? {
    
    return { zip($0, $1, $2, $3).map(transform) }
}

public func zip<A, B, C, D, E, F>(with transform: @escaping (A, B, C, D, E) -> F) -> (A?, B?, C?, D?, E?) -> F? {
    
    return { zip($0, $1, $2, $3, $4).map(transform) }
}

public func zip<A, B, C, D, E, F, G>(with transform: @escaping (A, B, C, D, E, F) -> G) -> (A?, B?, C?, D?, E?, F?) -> G? {
    
    return { zip($0, $1, $2, $3, $4, $5).map(transform) }
}

public func zip<A, B, C, D, E, F, G, H>(with transform: @escaping (A, B, C, D, E, F, G) -> H) -> (A?, B?, C?, D?, E?, F?, G?) -> H? {
    
    return { zip($0, $1, $2, $3, $4, $5, $6).map(transform) }
}
