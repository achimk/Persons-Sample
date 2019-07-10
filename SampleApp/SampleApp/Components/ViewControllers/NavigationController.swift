//
//  NavigationController.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

class NavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        enablePrefersLargeTitles()
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        enablePrefersLargeTitles()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        enablePrefersLargeTitles()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        Theme.NavigationBar.apply(to: navigationBar)
    }
    
    func enablePrefersLargeTitles() {
        
        if #available(iOS 11.0, *) {
            
            navigationBar.prefersLargeTitles = true
            
        }
    }
    
    func disablePrefersLargeTitles() {
        
        if #available(iOS 11.0, *) {
            
            navigationBar.prefersLargeTitles = false
            
        }
    }
}
