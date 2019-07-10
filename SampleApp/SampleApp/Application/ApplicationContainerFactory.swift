//
//  ApplicationContainerFactory.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import AppCore

struct ApplicationContainerFactory {
    
    static func create() -> ApplicationContainer {
        
        // FIXME: Wildcard for access token to start authenticated
        let accessToken: AccessToken = "testAccessToken"
        
        let accessTokenRepository = AccessTokenInMemoryRepository(with: accessToken)
        
        let container = ApplicationContainer(accessTokenRepository: accessTokenRepository)
        
        return container
    }
}
