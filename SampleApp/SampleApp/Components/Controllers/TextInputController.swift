//
//  TextInputController.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit


final class TextInputController {
    
    static let shared = TextInputController()
    
    private init() {
        _ = TextFieldFirstResponderController.shared
        _ = TextViewFirstResponderController.shared
    }
    
    func editedTextField() -> UITextField? {
        return TextFieldFirstResponderController.shared.editedTextField
    }
    
    func editedTextView() -> UITextView? {
        return TextViewFirstResponderController.shared.editedTextView
    }
    
    func editedTextInput() -> UIView? {
        return editedTextField() ?? editedTextView()
    }
    
    func resignFirstResponder() {
        editedTextField()?.resignFirstResponder()
        editedTextView()?.resignFirstResponder()
    }
}
