//
//  Activity.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/21/20.
//

import Foundation

struct Activity: Encodable, Decodable {
    
    var activityId: String
    var type: String
    var username: String
    var userId: String
    var userAvatar: String
    var postId: String
    var mediaUrl: String
    var comment: String
    var date: Double
}

