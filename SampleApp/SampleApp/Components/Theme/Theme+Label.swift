//
//  Theme+Label.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

extension Theme.Label {
    
    static func apply(_ style: Style = .h1, to label: UILabel) {
        
        
        switch style {
            
        case .h1:
            label.font = UIFont.systemFont(ofSize: 22)
            label.textColor = .hex(0x0d102a)
            
        case .h2:
            label.font = UIFont.systemFont(ofSize: 18)
            label.textColor = .hex(0x0d102a)
            
        case .h3:
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .hex(0x757575)
            
        case .h4:
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = .hex(0x757575)
            
        case .h5:
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = .hex(0x757575)
            
        case .h6:
            label.font = UIFont.systemFont(ofSize: 10)
            label.textColor = .hex(0x757575)
            
        case .h1_bold:
            label.font = UIFont.boldSystemFont(ofSize: 22)
            label.textColor = .hex(0x0d102a)
            
        case .h2_bold:
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.textColor = .hex(0x0d102a)
            
        case .h3_bold:
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textColor = .hex(0x757575)
            
        case .h4_bold:
            label.font = UIFont.boldSystemFont(ofSize: 14)
            label.textColor = .hex(0x757575)
            
        case .h5_bold:
            label.font = UIFont.boldSystemFont(ofSize: 12)
            label.textColor = .hex(0x757575)
            
        case .h1_italic:
            label.font = UIFont.italicSystemFont(ofSize: 22)
            label.textColor = .hex(0x0d102a)
            
        case .h2_italic:
            label.font = UIFont.italicSystemFont(ofSize: 18)
            label.textColor = .hex(0x0d102a)
            
        case .h3_italic:
            label.font = UIFont.italicSystemFont(ofSize: 16)
            label.textColor = .hex(0x757575)
            
        case .h4_italic:
            label.font = UIFont.italicSystemFont(ofSize: 14)
            label.textColor = .hex(0x757575)
            
        case .h5_italic:
            label.font = UIFont.italicSystemFont(ofSize: 12)
            label.textColor = .hex(0x757575)
        }
    }
}
