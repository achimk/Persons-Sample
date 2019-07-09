//
//  ErrorViewData.swift
//  AdaptersCore
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct ErrorViewData {
    
    public typealias Handler = () -> ()
    
    public var title: String?
    public var message: String
    public var handler: Handler?
    
    public init(title: String? = nil,
                message: String,
                handler: Handler? = nil) {
        
        self.title = title
        self.message = message
        self.handler = handler
    }
}
