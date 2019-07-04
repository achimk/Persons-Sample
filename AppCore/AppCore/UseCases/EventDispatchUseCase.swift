//
//  EventDispatchUseCase.swift
//  AppCore
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared

final class EventDispatchUseCase<T> {
    
    let eventDispatcher: EventDispatcher
    let execution: (@escaping EventDispatcher) -> Future<T, ApplicationError>
    
    init(eventDispatcher: @escaping EventDispatcher,
         execution: @escaping (@escaping EventDispatcher) -> Future<T, ApplicationError>) {
        
        self.eventDispatcher = eventDispatcher
        self.execution = execution
    }
    
    func prepare() -> Future<T, ApplicationError> {
        
        let box = MutableBox([Event]())
        
        let applyEvent: EventDispatcher = {
            box.set(box.value + [$0])
        }
        
        let future = execution(applyEvent)
        
        return future.andThen { [eventDispatcher] (result) in
            result.onSuccess { _ in
                box.value.forEach(eventDispatcher)
            }
        }
    }
}
