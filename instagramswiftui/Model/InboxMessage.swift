//
//  InboxMessage.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/19/20.
//

import Foundation

struct InboxMessage: Encodable, Decodable, Identifiable {
    var id = UUID()
    var lastMessage: String
    var username: String
    var type: String
    var date: Double
    var userId: String
    var avatarUrl: String
}
