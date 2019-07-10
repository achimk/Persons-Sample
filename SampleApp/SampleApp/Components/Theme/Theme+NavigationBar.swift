//
//  Theme+NavigationBar.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

extension Theme.NavigationBar {
    
    static func apply(to navigationBar: UINavigationBar) {
        
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = Theme.Color.primaryDark
        navigationBar.tintColor = .white
        
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        
        if #available(iOS 11.0, *) {
            
            navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            
        }
    }
}
