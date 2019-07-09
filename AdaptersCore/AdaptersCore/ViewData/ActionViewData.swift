//
//  ActionViewData.swift
//  AdaptersCore
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct ActionViewData: ControlStateful {
    
    public typealias Handler = () -> ()
    
    public var title: String
    public var controlState: ControlState
    public var isProcessing: Bool
    public var handler: Handler?
    
    public init(title: String,
                controlState: ControlState = .active,
                isProcessing: Bool = false,
                handler: Handler? = nil) {
        
        self.title = title
        self.controlState = controlState
        self.isProcessing = isProcessing
        self.handler = handler
    }
}
