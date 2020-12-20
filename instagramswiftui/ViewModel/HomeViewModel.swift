//
//  HomeViewModel.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/18/20.
//

import Foundation

import Foundation
import SwiftUI
import Firebase


class HomeViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    @Published var isLoading = false
    var listener: ListenerRegistration!
//    init() {
//        loadTimeline()
//    }
    
    func loadTimeline() {
        self.posts = []
        isLoading = true
        
        Api.Post.loadTimeline(onSuccess: { (posts) in
            self.isLoading = false
            if self.posts.isEmpty {
                self.posts = posts
            }
        }, newPost: { (post) in
            if !self.posts.isEmpty {
                self.posts.insert(post, at: 0)
            }
        }, deletePost: { (post) in
            if !self.posts.isEmpty {
                for (index, p) in self.posts.enumerated() {
                    if p.postId == post.postId {
                        self.posts.remove(at: index)
                    }
                }
            }
        }) { (listener) in
            self.listener = listener
        }
    }
}

