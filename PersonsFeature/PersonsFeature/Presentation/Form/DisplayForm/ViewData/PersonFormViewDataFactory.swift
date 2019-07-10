//
//  PersonFormViewDataFactory.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import AdaptersCore

struct PersonFormViewDataFactory {
    
    let localizer: PersonFormLocalizing
    let controller: PersonFormController
    let data: UnvalidatedPerson
    let invalidData: InvalidPersonData?
    
    func create() -> PersonFormViewData {
        
        // name
        let name = TextFieldViewData(
            text: data.name,
            placeholder: localizer.localizedNamePlaceholder,
            helperText: nil,
            inputMask: nil,
            isSecure: false,
            charactersCount: nil,
            editActions: .all,
            keyboard: .default,
            validationState: validationState(for: .name),
            controlState: .active,
            handler: controller.set(name:))
        
        // surname
        let surname = TextFieldViewData(
            text: data.surname,
            placeholder: localizer.localizedSurnamePlaceholder,
            helperText: nil,
            inputMask: nil,
            isSecure: false,
            charactersCount: nil,
            editActions: .all,
            keyboard: .default,
            validationState: validationState(for: .surname),
            controlState: .active,
            handler: controller.set(surname:))
        
        // email
        let email = TextFieldViewData(
            text: data.email,
            placeholder: localizer.localizedEmailPlaceholder,
            helperText: nil,
            inputMask: nil,
            isSecure: false,
            charactersCount: nil,
            editActions: .all,
            keyboard: .email,
            validationState: validationState(for: .email),
            controlState: .active,
            handler: controller.set(email:))
        
        // age
        let age = TextFieldViewData(
            text: data.age,
            placeholder: localizer.localizedAgePlaceholder,
            helperText: nil,
            inputMask: nil,
            isSecure: false,
            charactersCount: nil,
            editActions: .all,
            keyboard: .number,
            validationState: validationState(for: .age),
            controlState: .active,
            handler: controller.set(age:))
        
        // website
        let website = TextFieldViewData(
            text: data.website,
            placeholder: localizer.localizedWebsitePlaceholder,
            helperText: nil,
            inputMask: nil,
            isSecure: false,
            charactersCount: nil,
            editActions: .all,
            keyboard: .default,
            validationState: validationState(for: .website),
            controlState: .active,
            handler: controller.set(website:))
        
        // submit
        let submit = ActionViewData(
            title: localizer.localizedSubmitActionTitle,
            controlState: .active,
            isProcessing: false,
            handler: controller.submit)
        
        return PersonFormViewData(
            name: name,
            surname: surname,
            email: email,
            age: age,
            website: website,
            submit: submit)
    }
    
    private func validationState(for key: InvalidPersonData.Key) -> ValidationState {
        return invalidData.map {
            $0.errors[key].map { .invalid(message: localizer.localized(validationError: $0)) } ?? .valid
        } ?? .valid
    }
}
