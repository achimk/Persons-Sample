//
//  ApplicationSetup.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared
import AppCore

final class ApplicationSetup {
    
    private var once = Once.Token()
    
    static let shared = ApplicationSetup()
    
    private init() { }
    
    private func run(_ completed: () -> ()) {
        once.run {
            let container = ApplicationContainerFactory.create()
            AppCore.Application.setup(with: container)
            completed()
        }
    }
}

extension ApplicationSetup {
    
    static func start(with application: UIApplication,
                      options launchOptions: [UIApplication.LaunchOptionsKey: Any]?,
                      completed: () -> ()) {
        
        Bootstrap.run()
        
        shared.run(completed)
    }
}
