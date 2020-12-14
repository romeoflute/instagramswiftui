//
//  User.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/6/20.
//

import Foundation

import Foundation

struct User: Decodable, Encodable {
    var uid: String
    var email: String
    var profileImageUrl: String
    var username: String
    var bio: String
    var keywords: [String]
}
