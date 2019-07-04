//
//  DebugUseCase.swift
//  AppCore
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared

public typealias DebugEvent = Result<Any, ApplicationError>

public typealias DebugLogger = (DebugEvent) -> ()

func printDebugEvent(_ msg: String = "", _ event: DebugEvent) {
    
    let formatMessage: (String, Any) -> String = { (msg, obj) in
        let prefix = msg.isEmpty ? "->" : msg + " ->"
        return prefix + String(describing: obj)
    }
    
    switch event {
    case .success(let value):
        print(formatMessage(msg, value))
    case .failure(let error):
        print(formatMessage(msg, error))
    }
}

final class DebugUseCase<T> {
    
    let logger: DebugLogger?
    let execution: () -> Future<T, ApplicationError>
    
    init(logger: DebugLogger?,
         execution: @escaping () -> Future<T, ApplicationError>) {
        
        self.logger = logger
        self.execution = execution
    }

    func prepare() -> Future<T, ApplicationError> {
        
        guard let logger = self.logger else {
            return execution()
        }
        
        return execution().andThen(callback: { (result) in
            logger(result.map { $0 as Any })
        })
    }
}
