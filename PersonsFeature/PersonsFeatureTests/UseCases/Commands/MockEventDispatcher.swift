//
//  MockEventDispatcher.swift
//  PersonsFeatureTests
//
//  Created by Joachim Kret on 09/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import AppCore
@testable import PersonsFeature

final class MockEventDispatcher {
    
    var events: [Event] = []
    
    private(set) var invokedCreateEvent = false
    private(set) var invokedUpdateEvent = false
    private(set) var invokedDeleteEvent = false
    
    func dispatch(_ event: Event) {
        events.append(event)
        handle(event)
    }
    
    private func handle(_ event: Event) {
        if let event = event as? PersonEvent {
            handle(event)
        }
    }
    
    private func handle(_ event: PersonEvent) {
        switch event {
        case .created: invokedCreateEvent = true
        case .updated: invokedUpdateEvent = true
        case .deleted: invokedDeleteEvent = true
        }
    }
}
