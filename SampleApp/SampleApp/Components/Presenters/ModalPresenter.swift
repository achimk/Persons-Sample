//
//  ModalPresenter.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

final class ModalPresenter {
    
    enum Style {
        
        case fullScreen
        
        case centered
    }
    
    let sourceViewController: UIViewController
    
    init(sourceViewController: UIViewController) {
        self.sourceViewController = sourceViewController
    }
    
    func present(_ viewController: UIViewController, style: Style = .fullScreen, animated: Bool = true) {
        dismiss(viewController, animated: false)
        
        switch style {
            
        case .fullScreen:
            presentFullScreen(viewController, animated: animated)
            
        case .centered:
            // FIXME: Replace full screen for centered style in future
            presentFullScreen(viewController, animated: animated)
        }
    }
    
    func dismiss(_ viewController: UIViewController, animated: Bool = true) {
        viewController.dismiss(animated: animated, completion: nil)
    }
}

extension ModalPresenter {
    
    private func presentFullScreen(_ viewController: UIViewController, animated: Bool) {
        sourceViewController.present(viewController, animated: animated, completion: nil)
    }
}
