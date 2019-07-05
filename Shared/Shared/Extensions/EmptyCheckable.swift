//
//  EmptyCheckable.swift
//  Shared
//
//  Created by Joachim Kret on 05/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public protocol EmptyCheckable {
    
    var isEmpty: Bool { get }
}

extension String: EmptyCheckable { }

extension Dictionary: EmptyCheckable { }

extension Array: EmptyCheckable { }

extension Set: EmptyCheckable { }
