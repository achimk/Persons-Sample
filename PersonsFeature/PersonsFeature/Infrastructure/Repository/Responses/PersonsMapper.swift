//
//  PersonsMapper.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

struct PersonsMapper {

    func map(_ response: PersonsResponse) -> [Person] {
        return response.map(toPerson).compactMap { $0 }
    }
    
    func toPerson(_ response: PersonResponse) -> Person? {
        
        guard
            let id = response.id,
            let name = response.name,
            let surname = response.surname,
            let email = Email.create(response.email).value
        else {
            return nil
        }
        
        let age = response.age.flatMap { Age.create(String($0)).value }
        let website: Website? = nil
        
        return Person.init(
            id: PersonId(rawValue: id),
            name: name,
            surname: surname,
            email: email,
            age: age,
            website: website)
    }
}
