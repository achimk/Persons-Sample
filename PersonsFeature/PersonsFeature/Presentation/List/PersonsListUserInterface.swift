//
//  PersonsListUserInterface.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import AdaptersCore

public protocol PersonsListUserInterface: class {
 
    func present(viewData: PersonItemsViewData)
    
    func present(error viewData: ErrorViewData)
    
    func presentProgress()
    
    func dismissProgress()
}
