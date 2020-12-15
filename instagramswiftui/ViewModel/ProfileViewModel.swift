//
//  ProfileViewModel.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/15/20.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    var splitted: [[Post]] = []
    func loadUserPosts(userId: String) {
        isLoading = true
        Api.User.loadPosts(userId: userId) { (posts) in
            self.isLoading = false
            self.posts = posts
            self.splitted = self.posts.splited(into: 3)
        }
    }
}

