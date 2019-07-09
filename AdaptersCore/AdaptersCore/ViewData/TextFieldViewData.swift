//
//  TextFieldViewData.swift
//  AdaptersCore
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct TextFieldViewData: ControlStateful, ValidationStateful {
    
    public typealias Handler = (String?) -> ()
    
    public var text: String?
    public var placeholder: String?
    public var helperText: String?
    public var inputMask: String?
    public var isFilled: Bool { return text != nil }
    public var isSecure: Bool
    public var charactersCount: UInt?
    public var editActions: EditAction
    public var keyboard: Keyboard
    public var validationState: ValidationState
    public var controlState: ControlState
    public var handler: Handler?
    
    public init(text: String?,
                placeholder: String? = nil,
                helperText: String? = nil,
                inputMask: String? = nil,
                isSecure: Bool = false,
                charactersCount: UInt? = nil,
                editActions: EditAction = .all,
                keyboard: Keyboard = .default,
                validationState: ValidationState = .valid,
                controlState: ControlState = .active,
                handler: Handler? = nil) {
        
        self.text = text
        self.placeholder = placeholder
        self.helperText = helperText
        self.inputMask = inputMask
        self.isSecure = isSecure
        self.charactersCount = charactersCount
        self.editActions = editActions
        self.keyboard = keyboard
        self.validationState = validationState
        self.controlState = controlState
        self.handler = handler
    }
}

extension TextFieldViewData {
    
    public struct EditAction: OptionSet {
        
        public static let paste     = EditAction(rawValue: 1 << 0)
        public static let select    = EditAction(rawValue: 1 << 1)
        public static let selectAll = EditAction(rawValue: 1 << 2)
        public static let copy      = EditAction(rawValue: 1 << 3)
        public static let cut       = EditAction(rawValue: 1 << 4)
        public static let delete    = EditAction(rawValue: 1 << 5)
        
        public static let none: EditAction  = []
        
        public static let all: EditAction   = [
            .paste,
            .select,
            .selectAll,
            .copy,
            .cut,
            .delete
        ]
        
        public let rawValue: Int
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
}

extension TextFieldViewData {
    
    public enum Keyboard {
        
        case `default`
        
        case phone
        
        case url
        
        case email
        
        case decimal
        
        case number
        
        case numbersAndPunctuation
    }
}
