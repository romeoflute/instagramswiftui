//
//  Comment.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/18/20.
//

import Foundation

struct Comment: Encodable, Decodable, Identifiable {
    var id = UUID()
    var comment: String
    var ownerId: String
    var postId: String
    var username: String
    var date: Double
}

