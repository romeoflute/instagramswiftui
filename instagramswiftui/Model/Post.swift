//
//  Post.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/15/20.
//

import Foundation

struct Post: Encodable, Decodable {
    var caption: String
    var likes: [String: Bool]
    var location: String
    var ownerId: String
    var postId: String
    var username: String
    var avatar: String
    var mediaUrl: String
    var date: Double
    var likeCount: Int
}
