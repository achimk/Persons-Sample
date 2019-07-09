//
//  DataStore.swift
//  AdaptersCore
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared

public final class DataStore<Success, Failure: Swift.Error> {
    
    public typealias State = DataState<Success, Failure>
    
    private let future: (() -> Future<Success, Failure>)?
    
    private var subscriber: ((State, State) -> ())?
    
    public var state: State = .idle {
        didSet { subscriber?(oldValue, state) }
    }
    
    public init(_ future: (() -> Future<Success, Failure>)?) {
        self.future = future
    }
    
    public func subscribe(_ subscriber: @escaping (State, State) -> ()) {
        self.subscriber = subscriber
    }
    
    public func unsubscribe() {
        self.subscriber = nil
    }
    
    @discardableResult
    public func dispatch() -> Bool {
        
        var isAccepted = false
        
        state.onReady {
            
            guard let future = self.future else { return }
            
            isAccepted = true
            
            state = .processing(state.value)
            
            future().onComplete(callback: { [weak self] (result) in
                
                result.onSuccess({ (data) in
                    
                    self?.state = .success(data)
                })
                
                result.onFailure({ (errorReason) in
                    
                    self?.state = .failure(errorReason)
                })
            })
        }
        
        return isAccepted
    }
}
