//
//  PersonFormTypes.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared
import AppCore

typealias PersonSubmitter = (UnvalidatedPerson) -> ()
typealias PersonFormDataConsumer = (UnvalidatedPerson) -> ()
typealias PersonFormErrorsConsumer = (InvalidPersonData) -> ()
typealias PersonProvider = () -> Future<UnvalidatedPerson, ApplicationError>
typealias PersonSubmitProvider = (UnvalidatedPerson) -> Future<PersonId, ApplicationError>

