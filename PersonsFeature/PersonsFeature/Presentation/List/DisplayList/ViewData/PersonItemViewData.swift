//
//  PersonItemViewData.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct PersonItemViewData {
    
    public typealias SelectHandler = () -> ()
    public typealias DeleteHandler = () -> ()
    
    public var title: String
    public var description: String
    public var selectHandler: SelectHandler?
    public var deleteHandler: DeleteHandler?
}
