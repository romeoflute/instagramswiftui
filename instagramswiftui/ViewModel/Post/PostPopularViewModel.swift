//
//  PostPopularViewModel.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/18/20.
//

import Foundation

class PostPopularViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    var splitted: [[Post]] = []
    func loadPostPopular() {
        isLoading = true
        Api.Post.loadPosts() { (posts) in
            self.isLoading = false
            self.posts = posts
            self.splitted = self.posts.splited(into: 3)
        }
    }
}
