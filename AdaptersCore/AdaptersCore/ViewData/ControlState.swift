//
//  ControlState.swift
//  AdaptersCore
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public enum ControlState {
    
    case active
    
    case inactive
    
    case hidden
}

public protocol ControlStateful {
    var controlState: ControlState { get }
}

extension ControlStateful {
    
    public var isActive: Bool { return controlState == .active }
    
    public var isInactive: Bool { return controlState == .inactive || controlState == .hidden }
    
    public var isHidden: Bool { return controlState == .hidden }
    
    public var isVisible: Bool { return controlState == .active || controlState == .inactive }
}

extension ControlStateful {
    
    public func onActive(_ action: () -> ()) {
        if isActive { action() }
    }
    
    public func onInactive(_ action: () -> ()) {
        if isInactive { action() }
    }
    
    public func onHidden(_ action: () -> ()) {
        if isHidden { action() }
    }
    
    public func onVisible(_ action: () -> ()) {
        if isVisible { action() }
    }

}
