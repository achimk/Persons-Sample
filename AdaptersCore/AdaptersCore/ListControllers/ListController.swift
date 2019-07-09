//
//  ListController.swift
//  AdaptersCore
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared

public class ListController<T> {
    
    public enum Context {
        case main
        case userInteractive
        case userInitiated
        case utility
        case background
        case custom(queue: DispatchQueue)
        
        var queue: DispatchQueue {
            switch self {
            case .main: return .main
            case .userInteractive: return .global(qos: .userInteractive)
            case .userInitiated: return .global(qos: .userInitiated)
            case .utility: return .global(qos: .utility)
            case .background: return .global(qos: .background)
            case .custom(let queue): return queue
            }
        }
    }
    
    private var token = Once.Token()
    private let context: Context
    private var subscriber: (([T]) -> ())?
    private var sort: SortPredicate<T>?
    private var filter: FilterPredicate<T>?
    
    public internal(set) var all: [T] = []
    public internal(set) var list: [T] = []
    
    public init(context: Context = .userInteractive, input: [T] = []) {
        self.context = context
        self.all = input
    }
    
    @discardableResult
    public func subscribe(_ subscriber: @escaping ([T]) -> ()) -> Self {
        self.subscriber = subscriber
        return self
    }
    
    public func unsubscribe() {
        self.subscriber = nil
    }
    
    @discardableResult
    public func set(input: [T]) -> Self {
        all = input
        list = input
        return self
    }
    
    @discardableResult
    public func set(sort: @escaping SortPredicate<T>) -> Self {
        self.sort = sort
        return self
    }
    
    @discardableResult
    public func set(filter: @escaping FilterPredicate<T>) -> Self {
        self.filter = filter
        return self
    }
    
    @discardableResult
    public func resetSort() -> Self {
        self.sort = nil
        return self
    }
    
    @discardableResult
    public func resetFilter() -> Self {
        self.filter = nil
        return self
    }
    
    @discardableResult
    public func prepare() -> Cancellable {
        return prepare({ _ in })
    }
    
    @discardableResult
    public func prepare(_ completion: @escaping ([T]) -> ()) -> Cancellable {
        return prepare(map: { $0 }, completion: completion)
    }
    
    @discardableResult
    public func prepare<U>(map mapper: @escaping ([T]) -> U, completion: @escaping (U) -> ()) -> Cancellable {
        return prepare(map: mapper, cancelled: { }, completion: completion)
    }
    
    @discardableResult
    public func prepare<U>(map mapper: @escaping ([T]) -> U, cancelled: @escaping () -> (), completion: @escaping (U) -> ()) -> Cancellable {
        return dispatchPrepare(map: mapper, cancelled: cancelled, completion: completion)
    }
    
    @discardableResult
    private func dispatchPrepare<U>(map mapper: @escaping ([T]) -> U, cancelled: @escaping() -> (), completion: @escaping (U) -> ()) -> Cancellable {
        
        self.token.cancel()
        
        var newState = all
        let token = Once.Token()
        let queue = context.queue
        
        func run(_ action: () -> ()) {
            if !token.isCancelled { action() }
        }
        
        func run(_ action: () -> (), otherwise: () -> ()) {
            if !token.isCancelled { action() } else { otherwise() }
        }
        
        context.queue.async { [weak self, filter, sort] in
            
            run {
                if let filter = filter {
                    newState = newState.filter(filter)
                }
            }
            
            run {
                if let sort = sort {
                    newState = newState.sorted(by: sort)
                }
            }
            
            var mapped: U?
            
            run {
                mapped = mapper(newState)
            }
            
            run({
                
                self?.list = newState
                
                DispatchQueue.main.async {
                    
                    self?.subscriber?(newState)
                    
                    if let mapped = mapped { completion(mapped) }
                }
                
            }, otherwise: {
                
                DispatchQueue.main.async {
                    
                    cancelled()
                }
            })
        }
        
        self.token = token
        
        return token
    }
}
