//
//  OptionsGroupViewData.swift
//  AdaptersCore
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared

public struct OptionsGroupViewData: ControlStateful, ValidationStateful {
    
    public enum Options {
        case empty
        case nonEmpty(NonEmptyArray<OptionViewData>)
    }
    
    public var title: String?
    public var details: String?
    public var placeholder: String?
    public var validationState: ValidationState
    public let controlState: ControlState
    public let options: Options
    
    public var allOptions: [OptionViewData] {
        switch options {
        case .empty: return []
        case .nonEmpty(let container): return [container.head] + container.tail
        }
    }
    
    public init(title: String? = nil,
                details: String? = nil,
                placeholder: String? = nil,
                isInactive: Bool = false,
                validationState: ValidationState = .valid,
                options: [OptionViewData]) {
        
        self.title = title
        self.details = details
        self.placeholder = placeholder
        self.validationState = validationState
        
        if let head = options.first {
            let tail = Array(options.dropLast())
            self.options = .nonEmpty(NonEmptyArray(head, tail))
        } else {
            self.options = .empty
        }
        
        if isInactive {
            self.controlState = options.isEmpty ? .hidden : .inactive
        } else {
            self.controlState = options.isEmpty ? .hidden : .active
        }
    }
}
