//
//  TextField.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import MaterialComponents

/**
 Edit actions took from: https://gist.github.com/Gujci/201c76e67de95d17416295ef7e8f8386
 */
@IBDesignable
class TextField: MDCTextField {
    
    @IBInspectable var isPasteEnabled: Bool = true
    
    @IBInspectable var isSelectEnabled: Bool = true
    
    @IBInspectable var isSelectAllEnabled: Bool = true
    
    @IBInspectable var isCopyEnabled: Bool = true
    
    @IBInspectable var isCutEnabled: Bool = true
    
    @IBInspectable var isDeleteEnabled: Bool = true
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        switch action {
        case #selector(UIResponderStandardEditActions.paste(_:)) where !isPasteEnabled,
             #selector(UIResponderStandardEditActions.select(_:)) where !isSelectEnabled,
             #selector(UIResponderStandardEditActions.selectAll(_:)) where !isSelectAllEnabled,
             #selector(UIResponderStandardEditActions.copy(_:)) where !isCopyEnabled,
             #selector(UIResponderStandardEditActions.cut(_:)) where !isCutEnabled,
             #selector(UIResponderStandardEditActions.delete(_:)) where !isDeleteEnabled:
            return false
        default:
            return super.canPerformAction(action, withSender: sender)
        }
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
        leadingUnderlineLabel.numberOfLines = 0
    }
    
    private var calls: Int = 0
    private var ignoreLayoutUpdates = false {
        didSet {
            if !ignoreLayoutUpdates && calls > 0 {
                calls = 0
                
                setNeedsLayout()
                layoutIfNeeded()
                
                setNeedsUpdateConstraints()
                updateConstraintsIfNeeded()
            }
            
        }
    }
    
    func postponeLayoutUpdates() {
        ignoreLayoutUpdates = true
    }
    
    func commitLayoutUpdates() {
        ignoreLayoutUpdates = false
    }
    
    override func setNeedsLayout() {
        
        if ignoreLayoutUpdates { return }
        
        super.setNeedsLayout()
    }
    
    override func layoutIfNeeded() {
        
        calls += 1
        
        if ignoreLayoutUpdates { return }
        
        super.layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        
        if ignoreLayoutUpdates { return }
        
        super.layoutSubviews()
    }
    
    override func setNeedsUpdateConstraints() {
        
        if ignoreLayoutUpdates { return }
        
        super.setNeedsUpdateConstraints()
    }
    
    override func updateConstraintsIfNeeded() {
        
        if ignoreLayoutUpdates { return }
        
        super.updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        
        if ignoreLayoutUpdates { return }
        
        super.updateConstraints()
    }
}
