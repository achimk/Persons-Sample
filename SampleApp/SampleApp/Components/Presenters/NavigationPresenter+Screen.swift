//
//  NavigationPresenter+Screen.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

extension NavigationPresenter {
    
    func present(_ screen: ScreenType) {
        screen.viewController.hidesBottomBarWhenPushed = screen.properties.bottomBarHidden
        present(screen.viewController, animated: screen.properties.animated)
    }
    
    func dismiss(_ screen: ScreenType) {
        dismiss(screen.viewController, animated: screen.properties.animated)
    }
}
