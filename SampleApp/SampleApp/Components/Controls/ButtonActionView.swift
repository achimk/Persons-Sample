//
//  Created by Joachim Kret on 29/11/2018.
//  Copyright © 2018 Enterpryze. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents
import AdaptersCore

final class ButtonActionView: UIView, NibLoadable {
 
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var button: MDCButton!
    
    @IBAction func didSelect() {
        resignInputTextFirstResponder()
        handler?()
    }
    
    private var handler: (() -> ())?
    
    static func create() -> ButtonActionView {
        return ButtonActionView.loadFromNib()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        Theme.Button.apply(to: button)
        
        button.tintColor = .clear // Clear color for selected state
        button.setTitle(nil, for: .normal)
        activityIndicator.style = .white
        activityIndicator.isHidden = true
        
        backgroundColor = .clear
    }
    
    func update(with data: ActionViewData) {
        
        handler = data.isActive ? data.handler : nil

        button.setTitle(data.title, for: .normal)
        button.setEnabled(data.isActive, animated: false)
        
        activityIndicator.style = data.isActive ? .white : .gray
        activityIndicator.isHidden = !data.isProcessing
        
        if data.isProcessing {
            
            button.setTitle(nil, for: .normal)
            activityIndicator.startAnimating()
            
        } else {
            
            activityIndicator.stopAnimating()
            
        }
    }
    
    func update(with viewData: OptionViewData) {
        
        handler = viewData.isActive ? viewData.handler : nil
        
        button.isSelected = viewData.isSelected
        button.setTitle(viewData.title, for: .normal)
        button.setEnabled(viewData.isActive, animated: false)
        
        activityIndicator.isHidden = true
    }
    
}

extension ButtonActionView {
    
    func asButton() -> MDCButton { return button }
}
