//
//  UIStackView+Extensions.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

extension UIStackView {
    
    var isHorizontalLayout: Bool {
        return axis == .horizontal
    }
    
    var isVerticalLayout: Bool {
        return axis == .vertical
    }
}

extension UIStackView {
    
    func addArrangedSubview(_ view: UIView, insets: UIEdgeInsets) {
        
        let innerStackView = HiddableStackView()
        innerStackView.translatesAutoresizingMaskIntoConstraints = false
        innerStackView.axis = axis
        innerStackView.alignment = .fill
        innerStackView.distribution = .fill
        innerStackView.spacing = 0
        
        innerStackView.layoutMargins = insets
        innerStackView.isLayoutMarginsRelativeArrangement = true
        innerStackView.preservesSuperviewLayoutMargins = true
        
        innerStackView.addArrangedSubview(view)
        addArrangedSubview(innerStackView)
    }
    
    func addArrangedFlexibleSubview(_ view: UIView) {
        
        isHorizontalLayout
            ? view.setContentHuggingPriority(.defaultLow, for: .horizontal)
            : view.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        addArrangedSubview(view)
    }
}

extension UIStackView {
    
    @discardableResult
    func addLineSeparator(width: CGFloat = 0.5) -> UIView {
        
        let separatorView = UIView()
        separatorView.backgroundColor = Theme.Color.separator
        
        if isHorizontalLayout {
            separatorView.widthAnchor.constraint(equalToConstant: width).isActive = true
        } else {
            separatorView.heightAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        addArrangedSubview(separatorView)
        
        return separatorView
    }
    
    @discardableResult
    func addWhiteSpace(width: CGFloat) -> UIView {
        
        let separatorView = UIView()
        
        if isHorizontalLayout {
            separatorView.widthAnchor.constraint(equalToConstant: width).isActive = true
        } else {
            separatorView.heightAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        separatorView.backgroundColor = .clear
        
        addArrangedSubview(separatorView)
        
        return separatorView
    }
    
    @discardableResult
    func addFlexibleSpace() -> UIView {
        
        let flexibleView = isHorizontalLayout
            ? FlexibleView.horizontal()
            : FlexibleView.vertical()
        
        addArrangedSubview(flexibleView)
        
        return flexibleView
    }
    
}

class FlexibleView: UIView {
    
    static func horizontal() -> UIView {
        
        let flexibleView = UIView()
        flexibleView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        flexibleView.backgroundColor = .clear
        
        return flexibleView
    }
    
    static func vertical() -> UIView {
        
        let flexibleView = UIView()
        flexibleView.setContentHuggingPriority(.defaultLow, for: .vertical)
        flexibleView.backgroundColor = .clear
        
        return flexibleView
    }
}

private final class HiddableStackView: UIStackView {
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let view = object as? UIView, view.superview === self && keyPath == "hidden" {
            
            self.isHidden = view.isHidden
        }
    }
    
    override func addArrangedSubview(_ view: UIView) {
        super.addArrangedSubview(view)
        view.addObserver(self, forKeyPath: "hidden", options: [.initial, .new], context: nil)
    }
    
    override func removeArrangedSubview(_ view: UIView) {
        super.removeArrangedSubview(view)
        view.removeObserver(self, forKeyPath: "hidden")
    }
}
