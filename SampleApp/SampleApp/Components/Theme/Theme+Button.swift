//
//  Theme+Button.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import MaterialComponents

extension Theme.Button {
    
    static func apply(_ style: Style = .default, to button: Any) {
        
        switch style {
            
        case .default: applyDefaultStyle(button)
            
        case .selected: applySelectedStyle(button)
            
        case .unselected: applyUnselectedStyle(button)
        }
    }
}

extension Theme.Button {
    
    private static func applyDefaultStyle(_ button: Any) {
        
        switch button {
            
        case let container as ButtonActionView:
            applyDefaultStyle(to: container.asButton())
            
        case let button as MDCFloatingButton:
            applyDefaultStyle(to: button)
            
        case let button as MDCButton:
            applyDefaultStyle(to: button)
            
        default: break
        }
    }
    
    private static func applyDefaultStyle(to button: MDCButton) {
        
        let colorScheme = MDCSemanticColorScheme()
        colorScheme.primaryColor = .hex(0x303f9f)
        colorScheme.primaryColorVariant = .hex(0x757575)
        
        let scheme = MDCButtonScheme()
        scheme.colorScheme = colorScheme
        
        MDCContainedButtonThemer.applyScheme(scheme, to: button)
    }
    
    private static func applyDefaultStyle(to button: MDCFloatingButton) {
        
        let colorScheme = MDCSemanticColorScheme.init()
        colorScheme.secondaryColor = .clear
        
        let scheme = MDCButtonScheme()
        scheme.colorScheme = colorScheme
        
        let image = UIImage(named: "toggleIcon")
        button.setImage(image, for: .normal)
        
        MDCFloatingActionButtonThemer.applyScheme(scheme, to: button)
    }
}

extension Theme.Button {
    
    private static func applySelectedStyle(_ button: Any) {
        
        switch button {
            
        case let container as ButtonActionView: applySelectedStyle(to: container.asButton())
            
        case let button as MDCButton: applySelectedStyle(to: button)
            
        default: break
        }
    }
    
    private static func applySelectedStyle(to button: MDCButton) {
        
        let colorScheme = MDCSemanticColorScheme()
        colorScheme.primaryColor = Theme.Color.primaryDark
        colorScheme.onPrimaryColor = .white
        
        let scheme = MDCButtonScheme()
        scheme.colorScheme = colorScheme
        
        MDCContainedButtonThemer.applyScheme(scheme, to: button)
    }
}

extension Theme.Button {
    
    private static func applyUnselectedStyle(_ button: Any) {
        
        switch button {
            
        case let container as ButtonActionView: applyUnselectedStyle(to: container.asButton())
            
        case let button as MDCButton: applyUnselectedStyle(to: button)
            
        default: break
        }
    }
    
    private static func applyUnselectedStyle(to button: MDCButton) {
        
        let colorScheme = MDCSemanticColorScheme()
        colorScheme.primaryColor = Theme.Color.inactive
        colorScheme.onPrimaryColor = .black
        
        let scheme = MDCButtonScheme()
        scheme.colorScheme = colorScheme
        
        MDCContainedButtonThemer.applyScheme(scheme, to: button)
        
        
    }
}
