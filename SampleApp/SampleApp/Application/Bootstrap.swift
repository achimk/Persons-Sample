//
//  Bootstrap.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared

final class Bootstrap {
    
    private static let shared = Bootstrap()
    private var once = Once.Token()
    private init() { }
    
    private func prepare() {
        once.run {
            prepareUI()
        }
    }
}

extension Bootstrap {
    
    static func run() {
        shared.prepare()
    }
}
