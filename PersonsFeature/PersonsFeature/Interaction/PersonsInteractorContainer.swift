//
//  PersonsInteractorContainer.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 04/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

struct PersonsInteractorContainer {
    
    // queries
    let getPersonsGateway: GetPersonsGateway
    let getPersonDetailsGateway: GetPersonDetailsGateway
    
    // commands
    let createPersonGateway: CreatePersonGateway
    let updatePersonGateway: UpdatePersonGateway
    let deletePersonGateway: DeletePersonGateway
    
}
