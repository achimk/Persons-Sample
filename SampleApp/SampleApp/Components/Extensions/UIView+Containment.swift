//
//  UIView+Containment.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    public var isEmbedded: Bool { return superview != nil }
    
    @discardableResult
    public func embedded(into view: UIView, insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right).isActive = true
        return self
    }
    
    @discardableResult
    public func anchored(
        into view: UIView,
        insets: UIEdgeInsets = .zero) -> (top: NSLayoutConstraint, leading: NSLayoutConstraint, bottom: NSLayoutConstraint, trailing: NSLayoutConstraint) {
        
        translatesAutoresizingMaskIntoConstraints = true
        view.addSubview(self)
        
        let top = topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top)
        let bottom = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom)
        let leading = leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left)
        let trailing = trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right)
        
        top.isActive = true
        bottom.isActive = true
        leading.isActive = true
        trailing.isActive = true
        
        return (top, leading, bottom, trailing)
    }
    
    public func addSubview(_ view: UIView, withConstrainedEdgeInsets insets: UIEdgeInsets) {
        addSubview(view)
        
        view.topAnchor.constraint(equalTo: topAnchor, constant: insets.top).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right).isActive = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
