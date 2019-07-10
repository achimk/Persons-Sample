//
//  ApplicationErrorViewDataFactory.swift
//  AdaptersCore
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import AppCore

public struct ApplicationErrorViewDataFactory {
    
    public let error: ApplicationError
    public let localizer: ApplicationErrorLocalizing
    public var handler: (() -> ())?
    
    public init(error: ApplicationError,
                localizer: ApplicationErrorLocalizing,
                handler: (() -> ())? = nil) {
        
        self.error = error
        self.localizer = localizer
        self.handler = handler
    }
    
    public func create() -> ErrorViewData {
        let message = localizer.localized(applicationError: error)
        let handler = self.handler
        return ErrorViewData(title: nil, message: message, handler: handler)
    }
}
