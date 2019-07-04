//
//  Application.swift
//  AppCore
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared

public final class Application {
    
    public static var context: Application!
    
    @discardableResult
    public static func setup(with container: ApplicationContainer) -> Application {
        context = Application(container: container)
        return context
    }
    
    public let eventPublisher = PublishSubject<EventListener>()
    
    public var eventDispatcher: EventDispatcher {
        return { [eventPublisher] event in
            DispatchQueue.main.async {
                eventPublisher.notify { $0.handle(event) }
            }
        }
    }
    
    let container: ApplicationContainer
    
    private init(container: ApplicationContainer) {
        self.container = container
    }
}
