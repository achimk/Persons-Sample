//
//  PersonItemViewData.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct PersonItemViewData {
    
    public typealias Handler = () -> ()
    
    public let title: String
    public let description: String
    public let handler: Handler?
}
