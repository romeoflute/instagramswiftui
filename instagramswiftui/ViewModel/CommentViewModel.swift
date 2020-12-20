//
//  CommentViewModel.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/18/20.
//

import Foundation
import Firebase

class CommentViewModel: ObservableObject {
    
    @Published var comments: [Comment] = []
    @Published var isLoading = false
    var listener: ListenerRegistration!
    var post: Post!
    
    func loadComments() {
        self.comments = []
        self.isLoading = true
        
        Api.Comment.getComments(postId: post.postId, onSuccess: { (comments) in
            if self.comments.isEmpty {
                self.comments = comments
            }
        }, onError: { (errorMessage) in
            
        }, newComment: { (comment) in
            if !self.comments.isEmpty {
                self.comments.append(comment)
            }
        }) { (listener) in
            self.listener = listener
        }
    }
}
