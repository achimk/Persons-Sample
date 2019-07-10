//
//  AccessTokenInMemoryRepository.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import AppCore

final class AccessTokenInMemoryRepository: AccessTokenRepository {
    
    private var accessToken: AccessToken?
    
    init(with accessToken: AccessToken?) {
        self.accessToken = accessToken
    }
    
    func load() -> AccessToken? {
        return accessToken
    }
    
    func save(_ accessToken: AccessToken?) {
        self.accessToken = accessToken
    }
}
