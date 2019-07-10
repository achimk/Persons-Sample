//
//  Theme.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

struct Theme {
    
    struct TextField {
        
        enum Style {
            
            case `default`
        }
    }
    
    struct Button {
        
        enum Style {
            
            case `default`
            
            case selected
            
            case unselected
        }
    }
    
    struct Label {
        
        enum Style {
            
            case h1
            
            case h2
            
            case h3
            
            case h4
            
            case h5
            
            case h6
            
            case h1_bold
            
            case h2_bold
            
            case h3_bold
            
            case h4_bold
            
            case h5_bold
            
            case h1_italic
            
            case h2_italic
            
            case h3_italic
            
            case h4_italic
            
            case h5_italic
        }
    }
    
    struct Switch {
        
        enum Style {
            
            case `default`
        }
    }
    
    struct Separator {
        
    }
    
    struct TableView {
        
    }
    
    struct DropdownButton {
        
    }
    
    struct TabBar {
        
    }
    
    struct BottomBar {
        
    }
    
    struct SearchBar {
        
        enum Position {
            
            case tableHeader
            
            case navigationItem
        }
    }
    
    struct NavigationBar {
        
    }
}
