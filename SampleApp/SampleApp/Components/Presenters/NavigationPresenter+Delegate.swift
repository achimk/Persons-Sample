//
//  NavigationPresenter+Delegate.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

extension NavigationPresenter: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        
        if let screen = viewController as? ScreenType {
            
            navigationController.setNavigationBarHidden(
                screen.properties.navigationBarHidden,
                animated: screen.properties.animated)
        }
        
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        
        if let count = keyStackCount, currentStackCount() < count {
            
            delegate?.navigationPresenterShouldResingToBeKey(self)
        }
        
    }
}
