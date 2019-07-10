//
//  PersonFormUserInterface.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import AdaptersCore

public protocol PersonFormUserInterface: class {
    
    func present(viewData: PersonFormViewData)
    
    func present(error viewData: ErrorViewData)
    
    func presentProgress()
    
    func dismissProgress()
}
