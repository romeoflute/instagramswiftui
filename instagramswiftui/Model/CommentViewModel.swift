//
//  CommentViewModel.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/18/20.
//

import Foundation

class CommentViewModel: ObservableObject {
    
    @Published var comments: [Comment] = []
    @Published var isLoading = false
    var post: Post!
    
    func loadComments() {
        self.isLoading = true
        Api.Comment.getComments(postId: post.postId, onSuccess: { (comments) in
            
        }, onError: { (errorMessage) in
            
        }) { (comment) in
            
        }
    }
}
