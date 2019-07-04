//
//  Cancellable.swift
//  Shared
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public protocol Cancellable {
    
    var isCancelled: Bool { get }
    
    func cancel()
}
