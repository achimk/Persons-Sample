//
//  PublishSubject.swift
//  Shared
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public final class PublishSubject<Subject> {
    
    typealias WeakSet = Array<WeakBox>
    
    private(set) var subscribed: WeakSet = []
    
    public init() { }
    
    @discardableResult
    public func subscribe(_ target: Subject) -> Bool {
        let obj: AnyObject? = target as AnyObject
        guard let object = obj else { return false }
        
        subscribed = update(set: subscribed, closure: { (set) in
            set.append(WeakBox(object))
        })
        
        return true
    }
    
    @discardableResult
    public func unsubscribe(_ target: Subject) -> Bool {
        let obj: AnyObject? = target as AnyObject
        guard let object = obj else { return false }
        
        subscribed = update(set: subscribed, closure: { (set) in
            while let index = set.index(where: { $0 == object }) {
                set.remove(at: index)
            }
        })
        
        return true
    }
    
    public func notify(_ action: (Subject) -> ()) {
        subscribed.compactMap { $0.inner as? Subject }.forEach { (target) in
            action(target)
        }
    }
    
    private func update(set: WeakSet, closure: (inout WeakSet) -> ()) -> WeakSet {
        var filteredSet = set.filter { $0.inner != nil }
        closure(&filteredSet)
        return filteredSet
    }
}
