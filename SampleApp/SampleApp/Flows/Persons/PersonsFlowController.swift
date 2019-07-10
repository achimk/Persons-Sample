//
//  PersonsFlowController.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

final class PersonsFlowController: FlowController {
    
    let presenter: NavigationPresenter
    
    init(navigationController: UINavigationController) {
        presenter = NavigationPresenter(navigationController: navigationController)
    }
    
    func makeKeyAndVisible() {
        presentList()
    }
}
