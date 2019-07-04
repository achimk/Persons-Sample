//
//  Never.swift
//  Shared
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

public enum Never { }

extension Never: Swift.Error { }

extension Never: Equatable { }
