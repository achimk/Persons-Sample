//
//  ApplicationSetup.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import AppCore

final class ApplicationSetup {
    
    private var context: AppCore.Application?
    
    static let shared = ApplicationSetup()
    
    private init() { }
    
    private func run(_ completed: () -> ()) {
        guard context == nil else { return }
        let container = ApplicationContainerFactory.create()
        context = AppCore.Application.setup(with: container)
        completed()
    }
}

extension ApplicationSetup {
    
    static func start(with application: UIApplication,
                      options launchOptions: [UIApplication.LaunchOptionsKey: Any]?,
                      completed: () -> ()) {
        
        shared.run(completed)
    }
}
