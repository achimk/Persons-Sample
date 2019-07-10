//
//  PersonsListTypes.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared
import AppCore

typealias PersonsConsumer = (Result<[Person], ApplicationError>) -> ()
typealias PersonsDeleteConsumer = (NonEmptyArray<PersonId>) -> ()
typealias PersonsDeleteProvider = (NonEmptyArray<PersonId>) -> Future<NonEmptyArray<PersonId>, ApplicationError>
typealias PersonsListProvider = () -> Future<[Person], ApplicationError>
typealias PersonsListEventSubscriber = (EventListener) -> ()
