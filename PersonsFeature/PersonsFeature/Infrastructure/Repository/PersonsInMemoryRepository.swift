//
//  PersonsInMemoryRepository.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import Shared

final class PersonsInMemoryRepository {
    
    private var persons: [Person] = []
    
    init() {
        persons = loadPersons()
    }
    
    func all() -> [Person] { return persons }
    
    func find(with id: PersonId) -> Int? { return persons.firstIndex(where: { $0.id == id }) }
    
    func find(with id: PersonId) -> Person? { return persons.first(where: { $0.id == id}) }
    
    @discardableResult
    func append(_ person: Person) -> Bool {
        persons.append(person)
        return true
    }
    
    @discardableResult
    func update(_ person: Person, with id: PersonId) -> Bool {
        guard let index: Int = find(with: id) else { return false }
        persons[index] = person
        return true
    }
    
    @discardableResult
    func remove(with id: PersonId) -> Bool {
        guard let index: Int = find(with: id) else { return false }
        persons.remove(at: index)
        return true
    }
}

private class BundleLoader { }

fileprivate func loadPersons() -> [Person] {
    
    func json(from file: String) throws -> Data {
        let bundle = Bundle(for: BundleLoader.self)
        let path = bundle.path(forResource: file, ofType: "json") ?? ""
        let url = URL(fileURLWithPath: path)
        let data = try Data(contentsOf: url, options: .alwaysMapped)
        return data
    }
    
    func decode(data: Data) throws -> PersonsResponse {
        let decoder = JSONDecoder()
        let response = try decoder.decode(PersonsResponse.self, from: data)
        return response
    }
    
    func map(response: PersonsResponse) -> [Person] {
        return PersonsMapper().map(response)
    }
    
    var persons: [Person] = []
    
    do {
        
        persons = try "persons" |> json(from:) |> decode(data:) |> map(response:)
        
    } catch {
        // noop
    }
    
    return persons
}



