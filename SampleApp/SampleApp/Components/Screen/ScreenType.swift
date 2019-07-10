//
//  ScreenType.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

protocol ScreenType: class {
    
    static var identifier: String { get }
    
    var viewController: UIViewController { get }
    
    var properties: ScreenProperties { get }
}

extension ScreenType {
    
    static var identifier: String { return String(describing: self) }
    
    var properties: ScreenProperties { return ScreenProperties.default() }
}

extension ScreenType where Self: UIViewController {
    
    var viewController: UIViewController { return self }
}
