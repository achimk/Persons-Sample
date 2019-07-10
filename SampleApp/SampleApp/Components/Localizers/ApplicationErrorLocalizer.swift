//
//  ApplicationErrorLocalizer.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import AppCore

struct ApplicationErrorLocalizer {
    
    static func localized(applicationError: ApplicationError) -> String {
        switch applicationError {
        case .notFound:
            return NSLocalizedString("Resource not found", comment: "")
        case .accessDenied:
            return NSLocalizedString("Access denied", comment: "")
        case .accessRevoked:
            return NSLocalizedString("Access revoked", comment: "")
        case .connectionErrorOccured:
            return NSLocalizedString("Connection error occured", comment: "")
        case .unexpectedErrorOccurred:
            return NSLocalizedString("Unexpected error occured", comment: "")
        case .other(let error):
            return error.localizedDescription
        }
    }
}
