//
//  ModalPresenter+Screen.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

extension ModalPresenter {
    
    func present(_ screen: ScreenType, style: Style = .fullScreen) {
        present(screen.viewController, style: style, animated: screen.properties.animated)
    }
    
    func dismiss(_ screen: ScreenType) {
        dismiss(screen.viewController, animated: screen.properties.animated)
    }
}
