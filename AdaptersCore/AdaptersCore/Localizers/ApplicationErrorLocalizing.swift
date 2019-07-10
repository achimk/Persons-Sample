//
//  ApplicationErrorLocalizing.swift
//  AdaptersCore
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import AppCore

public protocol ApplicationErrorLocalizing {
    func localized(applicationError: ApplicationError) -> String
}
