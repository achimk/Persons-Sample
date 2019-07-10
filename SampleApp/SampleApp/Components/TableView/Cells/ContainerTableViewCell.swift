//
//  ContainerTableViewCell.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

final class ContainerTableViewCell<View>: InkTableViewCell, Reusable where View: UIView, View: NibLoadable {
    
    lazy var embeddedView: View = {
        return View.loadFromNib().embedded(into: contentView, insets: embeddedInsets)
    }()
    
    var embeddedInsets: UIEdgeInsets = .zero
}
