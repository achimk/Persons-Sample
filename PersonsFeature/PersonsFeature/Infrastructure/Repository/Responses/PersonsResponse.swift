//
//  PersonsResponse.swift
//  PersonsFeature
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation

struct PersonResponse: Codable {
    let id: String?
    let index: Int?
    let guid: String?
    let isActive: Bool?
    let balance: String?
    let picture: String?
    let age: Int?
    let name, surname, email, address: String?
    let about, registered: String?
    let latitude, longitude: Double?
    let tags: [String]?
    let friends: [FriendResponse]?
    let greeting, favoriteFruit: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case index, guid, isActive, balance, picture, age, name, surname, email, address, about, registered, latitude, longitude, tags, friends, greeting, favoriteFruit
    }
}

struct FriendResponse: Codable {
    let id: Int?
    let name: String?
}

typealias PersonsResponse = [PersonResponse]
