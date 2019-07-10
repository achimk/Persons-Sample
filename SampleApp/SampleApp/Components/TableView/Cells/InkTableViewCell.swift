//
//  InkTableViewCell.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents

class InkTableViewCell: UITableViewCell {
    
    private var lastTouch: CGPoint?
    private let inkView = MDCInkView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        installInkView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        installInkView()
    }
    
    private func installInkView() {
        selectionStyle = .none
        inkView.usesLegacyInkRipple = false
        inkView.frame = bounds
        addSubview(inkView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        inkView.cancelAllAnimations(animated: false)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        if let point = lastTouch, isSelected == false {
            
            if highlighted {
                
                inkView.startTouchBeganAnimation(at: point, completion: nil)
                
            } else {
                
                inkView.startTouchEndedAnimation(at: point, completion: nil)
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        lastTouch = touches.first?.location(in: self)
        
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        if let lastTouch = touches.first?.location(in: self) {
            
            inkView.startTouchEndedAnimation(at: lastTouch, completion: nil)
        }
    }
}
