//
//  ViewController.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController, ScreenType {
    
    private(set) var appearFirstTime = true
    private var endEditingHandler: EndEditingGestureHandler?
    
    var statusBarStyle: UIStatusBarStyle = .lightContent {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackButton()
        setupEndEditingHandler()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if appearFirstTime {
            viewWillAppearFirstTime(animated)
        }
        
        super.viewWillAppear(animated)
    }
    
    func viewWillAppearFirstTime(_ animated: Bool) {
        assert(appearFirstTime, "Should only be called on first time!")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if appearFirstTime {
            viewDidAppearFirstTime(animated)
            appearFirstTime = false
        }
        
        super.viewDidAppear(animated)
    }
    
    func viewDidAppearFirstTime(_ animated: Bool) {
        assert(appearFirstTime, "Should only be called on first time!")
    }
    
    private func setupBackButton() {
        
        guard let navigationController = navigationController else {
            return
        }
        
        guard navigationController.viewControllers.count > 1 else {
            return
        }
        
        let backBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "arrowBack"),
            style: .plain,
            target: navigationController,
            action: #selector(UINavigationController.popViewController(animated:)))
        
        self.navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    private func setupEndEditingHandler() {
        endEditingHandler = EndEditingGestureHandler(view: view)
    }
}

private final class EndEditingGestureHandler: NSObject, UIGestureRecognizerDelegate {
    
    private let view: UIView
    
    init(view: UIView) {
        
        self.view = view
        
        super.init()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(EndEditingGestureHandler.endEditing))
        
        tap.cancelsTouchesInView = false
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc func endEditing() {
        view.endEditing(true)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        guard let view = touch.view else { return false }
        
        let isNotSelfView = view !== self.view
        let isNotButton = !view.isKind(of: UIButton.self)
        let isNotTextField = !view.isKind(of: UITextField.self)
        let isNotTextView = !view.isKind(of: UITextView.self)
        
        return isNotSelfView && isNotButton && isNotTextField && isNotTextView
    }
}
