//
//  HomeViewModel.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/18/20.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    @Published var isLoading = false
    
    init() {
        loadTimeline()
    }
    
    func loadTimeline() {
        isLoading = true
        Api.Post.loadTimeline() { (posts) in
            self.isLoading = false
            self.posts = posts
        }
    }
}
