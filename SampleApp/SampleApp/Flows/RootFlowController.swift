//
//  RootFlowController.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

final class RootFlowController: FlowController {
    
    private let window = UIWindow()
    private let navigationController = NavigationController()
    
    let personsFlowController: PersonsFlowController
    
    static let shared = RootFlowController()
    
    private init() {
        navigationController.enablePrefersLargeTitles()
        personsFlowController = PersonsFlowController(navigationController: navigationController)
    }
    
    func makeKeyAndVisible() {
        
        if !window.isKeyWindow {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
        
        personsFlowController.makeKeyAndVisible()
    }
}
