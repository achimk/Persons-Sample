//
//  NavigationPresenter.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

protocol NavigationPresenterDelegate: class {
    func navigationPresenterShouldResingToBeKey(_ navigationPresenter: NavigationPresenter)
}


final class NavigationPresenter: NSObject {
    
    enum PushAction {
        
        case push
        
        case pushAsRoot
        
        case pushReplacingLast
    }
    
    enum PopAction {
        
        case pop(UIViewController)
        
        case popToRoot
    }
    
    private(set) var shouldPresentByReplacingLast = false
    private(set) var shouldPresentAsRoot = false
    private(set) var shouldPresentAsRootAnimated = true
    private(set) var keyStackCount: Int? // FIXME: Remove old functionality!
    private weak var rootViewController: UIViewController?
    
    let navigationController: UINavigationController
    
    var topViewController: UIViewController? {
        return navigationController.topViewController
    }
    
    weak var delegate: NavigationPresenterDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func makeRoot(_ screen: ScreenType?) {
        makeRoot(screen?.viewController)
    }
    
    func makeRoot(_ viewController: UIViewController?) {
        
        guard let viewController = viewController else {
            clearRoot()
            return
        }
        
        if navigationController.viewControllers.contains(viewController) {
            rootViewController = viewController
        }
    }
    
    func clearRoot() {
        rootViewController = nil
    }
    
    func setNeedsPresentAsRoot(animated: Bool = true) {
        shouldPresentAsRoot = true
        shouldPresentAsRootAnimated = animated
    }
    
    func clearNeedsPresentAsRoot() {
        shouldPresentAsRoot = false
    }
    
    func setNeedsPresentByReplacingLast() {
        shouldPresentByReplacingLast = true
    }
    
    func clearNeedsPresentByReplacingLast() {
        shouldPresentByReplacingLast = false
    }
    
    func present(_ viewController: UIViewController, action: PushAction = .push, animated: Bool = true) {
        var action = action
        var animated = animated
        
        if shouldPresentByReplacingLast {
            action = .pushReplacingLast
            clearNeedsPresentByReplacingLast()
        }
        
        if shouldPresentAsRoot {
            action = .pushAsRoot
            animated = shouldPresentAsRootAnimated
            clearNeedsPresentAsRoot()
        }
        
        switch action {
            
        case .push:
            let count = currentStackCount()
            navigationController.pushViewController(viewController, animated: animated)
            
            updateKeyStackCount {
                self.keyStackCount = count + 1
            }
            
        case .pushAsRoot:
            navigationController.setViewControllers([viewController], animated: animated)
            
            updateKeyStackCount {
                self.keyStackCount = 1
            }
            
        case .pushReplacingLast:
            var viewControllers = navigationController.viewControllers
            if !viewControllers.isEmpty { viewControllers.removeLast() }
            viewControllers.append(viewController)
            navigationController.setViewControllers(viewControllers, animated: animated)
            
            updateKeyStackCount {
                self.keyStackCount = viewControllers.count
            }
        }
    }
    
    func dismiss(_ viewController: UIViewController, animated: Bool = true) {
        dismiss(.pop(viewController), animated: animated)
    }
    
    func dismissToRoot(animated: Bool = true) {
        dismiss(.popToRoot, animated: animated)
    }
    
    func dismiss(_ action: PopAction, animated: Bool = true) {
        
        guard navigationController.topViewController != nil else { return }
        
        switch action {
        case .pop(let viewController):
            
            if navigationController.viewControllers.count == 1 {
                navigationController.dismiss(animated: animated, completion: nil)
            } else if navigationController.topViewController === viewController {
                navigationController.popViewController(animated: animated)
            } else {
                navigationController.popToViewController(viewController, animated: animated)
            }
            
        case .popToRoot:
            
            onRoot({ (viewController) in
                navigationController.popToViewController(viewController, animated: animated)
            }, otherwise: {
                navigationController.popToRootViewController(animated: animated)
            })
        }
    }
}

extension NavigationPresenter {
    
    func makeKey() {
        navigationController.delegate = self
        keyStackCount = nil
    }
    
    func isKey() -> Bool {
        return navigationController.delegate === self
    }
    
    func currentStackCount() -> Int {
        return navigationController.viewControllers.count
    }
    
    @discardableResult
    func updateKeyStackCount(_ action: (() -> ())? = nil) -> Bool {
        let shouldUpdate = isKey() && keyStackCount == nil
        if shouldUpdate {
            action?()
        }
        return shouldUpdate
    }
}

extension NavigationPresenter {
    
    private func onRoot(_ action: (UIViewController) -> (), otherwise: () -> ()) {
        if let viewController = rootViewController {
            if navigationController.viewControllers.contains(viewController) {
                action(viewController)
            } else {
                rootViewController = nil
                otherwise()
            }
        } else {
            otherwise()
        }
    }
}
