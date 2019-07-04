//
//  AccessTokenRepository.swift
//  AppCore
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public protocol AccessTokenRepository {
    
    func load() -> AccessToken?
    
    func save(_ accessToken: AccessToken?)
}
