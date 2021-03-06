//
//  ApplicationError.swift
//  AppCore
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public enum ApplicationError: Swift.Error {
    
    case notFound
    
    case accessDenied
    
    case accessRevoked
    
    case connectionErrorOccured
    
    case unexpectedErrorOccurred
    
    case other(Swift.Error) //Wildcart for other errors meaningful for application
}
