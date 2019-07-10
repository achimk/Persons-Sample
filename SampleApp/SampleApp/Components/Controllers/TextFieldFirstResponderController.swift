//
//  TextFieldFirstResponderController.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

final class TextFieldFirstResponderController {
    
    private(set) var editedTextField: UITextField?
    
    private var center: NotificationCenter {
        return NotificationCenter.default
    }
    
    private var textFieldTextDidBeginEditingObserver: Any?
    private var textFieldTextDidEndEditingObserver: Any?
    
    static let shared = TextFieldFirstResponderController()
    
    init() {
        addTextFieldTextDidBeginEditingObserver()
        addTextFieldTextDidEndEditingObserver()
    }
    
    @objc func resignFirstResponder() {
        editedTextField?.resignFirstResponder()
    }
    
    func addTextFieldTextDidBeginEditingObserver() {
        
        textFieldTextDidBeginEditingObserver = center.addObserver(
            forName: UITextField.textDidBeginEditingNotification,
            object: nil,
            queue: nil) { [weak self] (notification) in
                
                self?.editedTextField = (notification.object as? UITextField)
        }
    }
    
    func addTextFieldTextDidEndEditingObserver() {
        
        textFieldTextDidEndEditingObserver = center.addObserver(
            forName: UITextField.textDidEndEditingNotification,
            object: nil,
            queue: nil) { [weak self] (notification) in
                
                self?.editedTextField = nil
        }
    }
    
    deinit {
        
        if let textFieldTextDidBeginEditingObserver = textFieldTextDidBeginEditingObserver {
            center.removeObserver(textFieldTextDidBeginEditingObserver)
        }
        
        if let textFieldTextDidEndEditingObserver = textFieldTextDidEndEditingObserver {
            center.removeObserver(textFieldTextDidEndEditingObserver)
        }
    }
    
}
