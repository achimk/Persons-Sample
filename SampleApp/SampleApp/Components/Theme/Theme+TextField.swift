//
//  Theme+TextField.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import MaterialComponents

extension Theme.TextField {
    
    static func apply(_ style: Style = .default, to textField: Any) {
        
        switch textField {
            
        case let controller as MDCTextInputControllerUnderline:
            applyDefaultStyle(to: controller)
            
        case let controller as MDCTextInputControllerOutlined:
            applyDefaultStyle(to: controller)
            
        case let controller as MDCTextInputControllerOutlinedTextArea:
            applyDefaultStyle(to: controller)
            
        case let textField as UITextField:
            applyDefaultStyle(to: textField)
            
        default:
            break
        }
    }
}

extension Theme.TextField {
    
    private static func applyDefaultStyle(to controller: MDCTextInputControllerUnderline) {
        
        controller.floatingPlaceholderNormalColor = .hex(0x757575)
        controller.floatingPlaceholderActiveColor = .hex(0x757575)
        controller.errorColor = .hex(0xea0000)
        controller.activeColor = .hex(0x7C4DFF)
        controller.normalColor = .hex(0xC5CAE9)
        controller.disabledColor = .hex(0xC5CAE9)
        controller.borderFillColor = .hex(0xffffff)
        controller.inlinePlaceholderColor = .hex(0x757575)
        controller.textInputClearButtonTintColor = .hex(0x757575)
        controller.leadingUnderlineLabelTextColor = .hex(0x757575)
        controller.trailingUnderlineLabelTextColor = .hex(0x757575)
        controller.textInput?.textColor = .hex(0x757575)
        controller.textInput?.cursorColor = .hex(0x757575)
    }
    
    private static func applyDefaultStyle(to controller: MDCTextInputControllerOutlined) {
        
        controller.floatingPlaceholderNormalColor = .hex(0x757575)
        controller.floatingPlaceholderActiveColor = .hex(0x757575)
        controller.errorColor = .hex(0xea0000)
        controller.activeColor = .hex(0x7C4DFF)
        controller.normalColor = .hex(0xC5CAE9)
        controller.disabledColor = .hex(0xC5CAE9)
        controller.borderFillColor = .hex(0xffffff)
        controller.inlinePlaceholderColor = .hex(0x757575)
        controller.textInputClearButtonTintColor = .hex(0x757575)
        controller.leadingUnderlineLabelTextColor = .hex(0x757575)
        controller.trailingUnderlineLabelTextColor = .hex(0x757575)
        controller.textInput?.textColor = .hex(0x757575)
        controller.textInput?.cursorColor = .hex(0x757575)
    }
    
    private static func applyDefaultStyle(to controller: MDCTextInputControllerOutlinedTextArea) {
        
        controller.floatingPlaceholderNormalColor = .hex(0x757575)
        controller.floatingPlaceholderActiveColor = .hex(0x757575)
        controller.errorColor = .hex(0xea0000)
        controller.activeColor = .hex(0x7C4DFF)
        controller.normalColor = .hex(0xC5CAE9)
        controller.disabledColor = .hex(0xC5CAE9)
        controller.borderFillColor = .hex(0xffffff)
        controller.inlinePlaceholderColor = .hex(0x757575)
        controller.textInputClearButtonTintColor = .hex(0x757575)
        controller.leadingUnderlineLabelTextColor = .hex(0x757575)
        controller.trailingUnderlineLabelTextColor = .hex(0x757575)
        controller.textInput?.textColor = .hex(0x757575)
        controller.textInput?.cursorColor = .hex(0x757575)
    }
    
    private static func applyDefaultStyle(to textField: UITextField) {
        
        textField.textColor = .hex(0x757575)
        textField.backgroundColor = .white
        textField.tintColor = Theme.Color.primary
    }
}
