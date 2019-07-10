//
//  AlertController.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit
import AdaptersCore

struct AlertViewData {
    
    enum Style {
        
        case inform
        
        case alert
        
        case error
    }
    
    struct Action {
        
        typealias Handler = () -> ()
        
        var title: String
        
        var style: UIAlertAction.Style = .default
        
        var isActive: Bool = true
        
        var isSelected: Bool = false
        
        var handler: Handler?
    }
    
    var title: String?
    var message: String
    var actions: [Action]
    
    init(title: String? = nil,
         message: String,
         style: Style = .inform,
         handler: Action.Handler? = nil) {
        
        self.title = title
        self.message = message
        
        switch style {
            
        case .inform:
            self.actions = informActions(for: handler)
            
        case .alert:
            self.actions = alertActions(for: handler)
            
        case .error:
            self.actions = errorActions(for: handler)
        }
    }
    
    init(title: String? = nil,
         message: String,
         actions: [Action]) {
        
        self.title = title
        self.message = message
        self.actions = actions
    }
}

final class AlertController {
    
    let viewData: AlertViewData
    
    init(_ viewData: AlertViewData) {
        self.viewData = viewData
    }
    
    init(_ viewData: ErrorViewData) {
        let hasHandler = viewData.handler != nil
        self.viewData = AlertViewData(
            title: viewData.title,
            message: viewData.message,
            style: hasHandler ? .error : .inform,
            handler: viewData.handler)
    }
    
    init(_ viewData: OptionsGroupViewData) {
        
        var actions = viewData.allOptions.map {
            
            AlertViewData.Action(
                title: $0.title,
                style: .default,
                isActive: $0.isActive,
                isSelected: $0.isSelected,
                handler: $0.handler)
            
            }
        
        actions.append(cancelAction(for: nil))
        
        self.viewData = AlertViewData(
            title: viewData.title,
            message: viewData.details ?? "",
            actions: actions)
    }
    
    init(title: String?, message: String?) {
        self.viewData = AlertViewData(
            title: title,
            message: message ?? "",
            style: .inform,
            handler: nil)
    }
    
    func show() {
        
        let alert = UIAlertController(
            style: .alert,
            title: viewData.title,
            message: viewData.message)
        
        viewData.actions.forEach { (action) in
            
            alert.addAction(
                image: nil,
                title: action.title,
                color: nil,
                style: action.style,
                isEnabled: true,
                isSelected: action.isSelected,
                handler: { _ in action.handler?() })
        }
        
        alert.show()
    }
}


fileprivate func alertActions(for handler: AlertViewData.Action.Handler?) -> [AlertViewData.Action] {
    
    let okAction = AlertViewData.Action(
        title: NSLocalizedString("OK", comment: ""),
        style: .default,
        isActive: true,
        isSelected: false,
        handler: handler)
    
    let cancelAction = AlertViewData.Action(
        title: NSLocalizedString("Cancel", comment: ""),
        style: .default,
        isActive: true,
        isSelected: false,
        handler: nil)
    
    return [okAction, cancelAction]
}

fileprivate func errorActions(for handler: AlertViewData.Action.Handler?) -> [AlertViewData.Action] {
    
    let okAction = AlertViewData.Action(
        title: NSLocalizedString("OK", comment: ""),
        style: .default,
        isActive: true,
        isSelected: false,
        handler: nil)
    
    let retryAction = AlertViewData.Action(
        title: NSLocalizedString("Retry", comment: ""),
        style: .default,
        isActive: true,
        isSelected: false,
        handler: handler)
    
    return [okAction, retryAction]
}

fileprivate func informActions(for handler: AlertViewData.Action.Handler?) -> [AlertViewData.Action] {
    
    let okAction = AlertViewData.Action(
        title: NSLocalizedString("OK", comment: ""),
        style: .default,
        isActive: true,
        isSelected: false,
        handler: handler)
    
    return [okAction]
}

fileprivate func cancelAction(for handler: AlertViewData.Action.Handler?) -> AlertViewData.Action {
    
    let cancelAction = AlertViewData.Action(
        title: NSLocalizedString("Cancel", comment: ""),
        style: .cancel,
        isActive: true,
        isSelected: false,
        handler: nil)
    
    return cancelAction
}
