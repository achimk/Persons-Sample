//
//  AuthorizedUseCase.swift
//  AppCore
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared

final class AuthorizedUseCase<T> {
    
    let accessTokenRepository: AccessTokenRepository
    let eventDispatcher: EventDispatcher
    let execution: (AccessToken) -> Future<T, ApplicationError>
    
    init(accessTokenRepository: AccessTokenRepository,
         eventDispatcher: @escaping EventDispatcher,
         execution: @escaping (AccessToken) -> Future<T, ApplicationError>) {
        
        self.accessTokenRepository = accessTokenRepository
        self.eventDispatcher = eventDispatcher
        self.execution = execution
    }
    
    func prepare() -> Future<T, ApplicationError> {
        
        guard let token = accessTokenRepository.load() else {
            return Future.init(error: ApplicationError.accessDenied)
        }
        
        let future = execution(token)
        
        let ifInvalidAccess: (Swift.Error) -> Bool = {
            if let error = $0 as? ApplicationError {
                switch error {
                case .accessDenied, .accessRevoked: return true
                default: return false
                }
            }
            return false
        }
        
        return future.andThen { [accessTokenRepository, eventDispatcher] (result) in
            result.onFailure {
                if ifInvalidAccess($0) {
                    accessTokenRepository.save(nil)
                    eventDispatcher(AccessEvent.authenticationRevoked)
                }
            }
        }
    }
}
