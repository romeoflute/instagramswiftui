//
//  CommentInputViewModel.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/18/20.
//

import Foundation
import SwiftUI
import FirebaseAuth

class CommentInputViewModel: ObservableObject {
    
    var post: Post!
    
    func addComments(text: String, onSuccess: @escaping() -> Void) {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        guard let username = Auth.auth().currentUser?.displayName else { return }
        guard let avatarUrl = Auth.auth().currentUser?.photoURL?.absoluteString else { return }

        Api.Comment.sendComment(text: text, username: username, avatarUrl: avatarUrl, ownerId: currentUserId, postId: post.postId, onSuccess: {
            onSuccess()
        }) { (errorMessage) in
            print(errorMessage)
        }
    }
}

