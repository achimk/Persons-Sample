//
//  Optional+Extensions.swift
//  Shared
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

extension Optional {
    
    public func ifPresent(_ action: (Wrapped) -> ()) {
        map { action($0) }
    }
    
    public var isPresent: Bool {
        return map { _ in true } ?? false
    }
}
