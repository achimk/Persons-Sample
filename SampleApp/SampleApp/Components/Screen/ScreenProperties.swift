//
//  ScreenProperties.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

struct ScreenProperties {
    
    var navigationBarHidden: Bool
    var bottomBarHidden: Bool
    var animated: Bool
    
    static func `default`() -> ScreenProperties {
        return ScreenProperties(
            navigationBarHidden: false,
            bottomBarHidden: true,
            animated: true)
    }
}
