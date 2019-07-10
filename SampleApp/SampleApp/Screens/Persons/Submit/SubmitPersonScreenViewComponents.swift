//
//  SubmitPersonScreenViewComponents.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import PersonsFeature

struct SubmitPersonScreenViewComponents {
    
    let name = TextFieldView.create()
    
    let surname = TextFieldView.create()
    
    let email = TextFieldView.create()
    
    let age = TextFieldView.create()
    
    let website = TextFieldView.create()
    
    let submit = ButtonActionView.create()
    
    func update(with viewData: PersonFormViewData) {
        
        name.update(with: viewData.name)
        
        surname.update(with: viewData.surname)
        
        email.update(with: viewData.email)
        
        age.update(with: viewData.age)
        
        website.update(with: viewData.website)
        
        submit.update(with: viewData.submit)
    }
}
