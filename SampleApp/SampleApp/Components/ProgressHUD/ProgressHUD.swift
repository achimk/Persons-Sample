//
//  ProgressHUD.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import PKHUD

final class ProgressHUD {
    
    static func setup(_ view: UIView) -> PKHUD {
        
        if let hud = view.hud { return hud }
        
        let hud = PKHUD()
        hud.dimsBackground = false
        hud.userInteractionOnUnderlyingViewsEnabled = false
        
        view.hud = hud
        
        return hud
    }
    
    static func show(on view: UIView) {
        
        let hud = setup(view)
        
        hud.contentView = PKHUDProgressView()
        
        hud.show(onView: view)
    }
    
    static func hide(from view: UIView, animated: Bool = false) {
        
        let hud = setup(view)
        
        hud.hide(animated)
    }
    
    static func succeeded(onView view: UIView, _ completion: (() -> ())? = nil) {
        
        let hud = setup(view)
        
        hud.contentView = PKHUDSuccessView()
        
        hud.show(onView: view)
        hud.hide(afterDelay: 0.333) { _ in completion?() }
    }
    
    static func failed(onView view: UIView, _ completion: (() -> ())? = nil) {
        
        let hud = setup(view)
        
        hud.contentView = PKHUDErrorView()
        
        hud.show(onView: view)
        hud.hide(afterDelay: 0.333) { _ in completion?() }
    }
}

extension UIView {
    
    struct AssociatedKeys {
        static var hud: UInt8 = 0
    }
    
    fileprivate(set) var hud: PKHUD? {
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.hud, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.hud) as? PKHUD
        }
    }
    
    
}
