//
//  Chat.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/19/20.
//

import Foundation

struct Chat: Encodable, Decodable {
    var messageId: String
    var textMessage: String
    var avatarUrl: String
    var photoUrl: String
    var senderId: String
    var username: String
    var date: Double
}
