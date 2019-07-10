//
//  TableViewCells.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

final class DefaultTableViewCell: InkTableViewCell, Reusable {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let textLabel = textLabel {
            Theme.Label.apply(.h4, to: textLabel)
        }
        
        if let detailTextLabel = detailTextLabel {
            Theme.Label.apply(.h5, to: detailTextLabel)
        }
    }
}

final class SubtitleTableViewCell: InkTableViewCell, Reusable {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let textLabel = textLabel {
            Theme.Label.apply(.h4, to: textLabel)
        }
        
        if let detailTextLabel = detailTextLabel {
            Theme.Label.apply(.h5, to: detailTextLabel)
        }
    }
}

final class ValueTableViewCell: InkTableViewCell, Reusable {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let textLabel = textLabel {
            Theme.Label.apply(.h4, to: textLabel)
        }
        
        if let detailTextLabel = detailTextLabel {
            Theme.Label.apply(.h5, to: detailTextLabel)
        }
    }
}

final class ValueAltTableViewCell: InkTableViewCell, Reusable {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value2, reuseIdentifier: reuseIdentifier)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let textLabel = textLabel {
            Theme.Label.apply(.h4, to: textLabel)
        }
        
        if let detailTextLabel = detailTextLabel {
            Theme.Label.apply(.h5, to: detailTextLabel)
        }
    }
}
