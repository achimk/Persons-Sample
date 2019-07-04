//
//  ApplicationContainer.swift
//  AppCore
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public struct ApplicationContainer {
    
    public let accessTokenRepository: AccessTokenRepository
    
    public init(accessTokenRepository: AccessTokenRepository) {
        self.accessTokenRepository = accessTokenRepository
    }
}
