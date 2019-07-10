//
//  TextFieldView.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit
import Shared
import AdaptersCore
import MaterialComponents
//import InputMask

final class TextFieldView: UIView {
    
    private let textField = TextField()
    private var secureTextEyeView = SecureTextEyeView()
    private var textFieldController: MDCTextInputControllerBase!
//    private var maskedTextFieldController = MaskedTextFieldController()
    private var data: TextFieldViewData?
    
    static func create() -> TextFieldView {
        return TextFieldView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
    }
    
    var isEditing: Bool {
        return textField.isEditing
    }
    
    var isMaskActive: Bool {
//        return maskedTextFieldController.listener != nil
        return false
    }
    
    var isSecureTextEyeActive: Bool {
        return secureTextEyeView.delegate != nil
    }
    
    var isCharactersCounterActive: Bool {
        return textFieldController.characterCountViewMode != .never
    }
    
    var text: String? {
        set {
            
            // Break set new value (if equal) to not break animation during leave fucus
            guard newValue != text else { return }
            
            if isMaskActive {
//                let caretString = CaretString(string: newValue ?? "")
//                let result = maskedTextFieldController.primaryMask.apply(toText: caretString)
//                maskedTextFieldController.result = result
                textField.text = newValue
            } else {
                textField.text = newValue
            }
        }
        get {
//            return isMaskActive
//                ? maskedTextFieldController.result?.extractedValue
//                : textField.text
            return textField.text
        }
    }
    
    var textAlignment: NSTextAlignment {
        set { textField.textAlignment = newValue }
        get { return textField.textAlignment }
    }
    
    var clearButtonMode: UITextField.ViewMode {
        set { textField.clearButtonMode = newValue }
        get { return textField.clearButtonMode }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        finishInitialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        finishInitialize()
    }
    
    private func finishInitialize() {
        
        installTextField()
        
        textFieldController = TextInputControllerUnderline(textInput: textField)
        textFieldController.characterCountViewMode = .never
        textFieldController.isFloatingEnabled = true
        
        Theme.TextField.apply(to: textFieldController)
        
        textField.trailingViewMode = .never
        textField.delegate = self
    }
    
    private func installTextField() {
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        
        textField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func update(with data: TextFieldViewData) {
        
        textField.postponeLayoutUpdates()
        
        self.data = data
        
        updateEditActions(data.editActions)
        
        updateKeyboard(data.keyboard)
        
        updateMask(data.inputMask)
        
        updateCharactersCount(data.charactersCount)
        
        updateSecureEye(data.isSecure)

        textField.isEnabled = data.isActive
        
        if textField.placeholder != data.placeholder {
            textField.placeholder = data.placeholder
        }
        
        if textFieldController.errorText != nil {
            textFieldController.setErrorText(nil, errorAccessibilityValue: nil)
        }
        
        let helperText = data.helperText ?? " "
        if textFieldController.helperText != helperText {
            textFieldController.setHelperText(helperText, helperAccessibilityLabel: nil)
        }
        
        if !isEditing {
            text = data.text
            
            if let errorMessage = data.errorMessage {
                textFieldController.setErrorText(errorMessage, errorAccessibilityValue: nil)
            }
        }
        
        textField.commitLayoutUpdates()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Hotfix regarding wrong position of trailing underline label
        self.textFieldController.textInput?.setNeedsUpdateConstraints()
        self.textFieldController.textInput?.updateConstraintsIfNeeded()
    }
}

//extension TextFieldView: MaskedTextFieldDelegateListener {
extension TextFieldView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldController.setErrorText(nil, errorAccessibilityValue: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        data?.handler?(text)
    }
}

extension TextFieldView {
    
    private func updateEditActions(_ editActions: TextFieldViewData.EditAction) {
        
        textField.isPasteEnabled = editActions.contains(.paste)
        textField.isSelectEnabled = editActions.contains(.select)
        textField.isSelectAllEnabled = editActions.contains(.selectAll)
        textField.isCopyEnabled = editActions.contains(.copy)
        textField.isCutEnabled = editActions.contains(.cut)
        textField.isDeleteEnabled = editActions.contains(.delete)
    }
    
    private func updateKeyboard(_ keyboard: TextFieldViewData.Keyboard) {
        
        switch keyboard {
            
        case .default:
            textField.keyboardType = .default
        case .phone:
            textField.keyboardType = .phonePad
        case .email:
            textField.keyboardType = .emailAddress
        case .url:
            textField.keyboardType = .URL
        case .decimal:
            textField.keyboardType = .decimalPad
        case .number:
            textField.keyboardType = .numberPad
        case .numbersAndPunctuation:
            textField.keyboardType = .numbersAndPunctuation
            
        }
    }
    
    private func updateCharactersCount(_ count: UInt?) {
        
        if let count = count, count > 0 {
            textFieldController.characterCountMax = count
            textFieldController.characterCountViewMode = .always
        } else {
            textFieldController.characterCountMax = 0
            textFieldController.characterCountViewMode = .never
        }
    }
    
    private func updateMask(_ mask: String?) {
        switch mask {
        case .none:
            deactivateTextFieldMask()
        case .some(let mask):
            activateTextFieldMask(mask)
        }
    }
    
    private func activateTextFieldMask(_ mask: String) {
        
//        if maskedTextFieldController.primaryMaskFormat != mask {
//            maskedTextFieldController.primaryMaskFormat = mask
//        }
//
//        if !isMaskActive {
//            textField.delegate = maskedTextFieldController
//            maskedTextFieldController.autocompleteOnFocus = false
//            maskedTextFieldController.listener = self
//        }
        
    }
    
    private func deactivateTextFieldMask() {
        
//        guard isMaskActive else { return }
//        maskedTextFieldController.listener = nil
//        textField.delegate = self
        
    }
    
}

extension TextFieldView: SecureTextEyeViewDelegate {
    
    private func updateSecureEye(_ isSecure: Bool) {
        isSecure ? activateSecureEye() : deactivateSecureEye()
    }
    
    private func activateSecureEye() {
        
        guard !isSecureTextEyeActive else { return }
        
        secureTextEyeView.translatesAutoresizingMaskIntoConstraints = false
        secureTextEyeView.delegate = self
        secureTextEyeView.eyeState = .closed
        textField.trailingView = secureTextEyeView
        textField.trailingViewMode = .always
        textField.clearButtonMode = .never
        textField.isSecureTextEntry = true
        
    }
    
    private func deactivateSecureEye() {
        
        guard isSecureTextEyeActive else { return }
        
        secureTextEyeView.delegate = nil
        textField.trailingView = nil
        textField.clearButtonMode = .whileEditing
        textField.isSecureTextEntry = false
    }
    
    func secureTextEyeViewDidOpenEye(_ view: SecureTextEyeView) {
        textField.isSecureTextEntry = false
    }
    
    func secureTextEyeViewDidCloseEye(_ view: SecureTextEyeView) {
        textField.isSecureTextEntry = true
    }
}

//private final class MaskedTextFieldController: MaskedTextFieldDelegate {
//
//    var result: Mask.Result?
//
//    override func notifyOnMaskedTextChangedListeners(forTextField textField: UITextField, result: Mask.Result) {
//
//        self.result = result
//
//        super.notifyOnMaskedTextChangedListeners(forTextField: textField, result: result)
//    }
//}

private final class TextInputControllerUnderline: MDCTextInputControllerUnderline {
    
    override func trailingViewRect(forBounds bounds: CGRect, defaultRect: CGRect) -> CGRect {
        
        let bounds = textInput?.bounds ?? bounds
        var rect = defaultRect
        
        // Hotfix regarding wrong position of trailing view after did end editing
        // or switching state of SecureTextEyeView
        rect.origin.x = bounds.width - rect.width
        textInput?.trailingView?.frame = rect
        
        return rect
    }
}
