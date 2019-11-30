//
//  User.swift
//  FriendFace_MILESTONE
//
//  Created by roblack on 11/27/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import Foundation

struct Response: Codable {
    var users: [User]
}

struct User : Codable, Identifiable {
    let id : String
    let isActive : Bool?
    let name : String
    let age : Int?
    let company : String
    let email : String
    let address : String?
    let about : String?
    let registered : String?
    let tags : [String]
    let friends : [Friend]
}

struct Friend : Codable {
    let id : String?
    let name : String
}
