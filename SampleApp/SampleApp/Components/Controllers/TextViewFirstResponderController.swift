//
//  TextViewFirstResponderController.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

final class TextViewFirstResponderController {
    
    private(set) var editedTextView: UITextView?
    
    private var center: NotificationCenter {
        return NotificationCenter.default
    }
    
    private var textViewTextDidBeginEditingObserver: Any?
    private var textViewTextDidEndEditingObserver: Any?
    
    static let shared = TextViewFirstResponderController()
    
    init() {
        addTextViewTextDidBeginEditingObserver()
        addTextViewTextDidEndEditingObserver()
    }
    
    @objc func resignFirstResponder() {
        editedTextView?.resignFirstResponder()
    }
    
    func addTextViewTextDidBeginEditingObserver() {
        
        textViewTextDidBeginEditingObserver = center.addObserver(
            forName: UITextView.textDidBeginEditingNotification,
            object: nil,
            queue: nil) { [weak self] (notification) in
                
                self?.editedTextView = (notification.object as? UITextView)
        }
    }
    
    func addTextViewTextDidEndEditingObserver() {
        
        textViewTextDidEndEditingObserver = center.addObserver(
            forName: UITextView.textDidEndEditingNotification,
            object: nil,
            queue: nil) { [weak self] (notification) in
                
                self?.editedTextView = nil
        }
    }
    
    deinit {
        
        if let textViewTextDidBeginEditingObserver = textViewTextDidBeginEditingObserver {
            center.removeObserver(textViewTextDidBeginEditingObserver)
        }
        
        if let textViewTextDidEndEditingObserver = textViewTextDidEndEditingObserver {
            center.removeObserver(textViewTextDidEndEditingObserver)
        }
    }
    
}
