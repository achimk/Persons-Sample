//
//  OptionViewData.swift
//  AdaptersCore
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct OptionViewData: ControlStateful, ValidationStateful {
    
    public typealias Handler = () -> ()
    
    public var title: String
    public var details: String?
    public var placeholder: String?
    public var errorMessage: String?
    public var isSelected: Bool
    public var validationState: ValidationState
    public var controlState: ControlState
    public var handler: Handler?
    
    public init(title: String,
                details: String? = nil,
                placeholder: String? = nil,
                isSelected: Bool,
                validationState: ValidationState = .valid,
                controlState: ControlState = .active,
                handler: Handler? = nil) {
        
        self.title = title
        self.details = details
        self.placeholder = placeholder
        self.isSelected = isSelected
        self.validationState = validationState
        self.controlState = controlState
        self.handler = handler
    }
}
