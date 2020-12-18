//
//  CommentAPI.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/18/20.
//

import Foundation
import FirebaseAuth
import FirebaseStorage

class CommentApi {
    func sendComment(text: String, username: String, avatar: String, ownerId: String, postId: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        let comment = Comment(comment: text, ownerId: ownerId, postId: postId, username: username, date: Date().timeIntervalSince1970)
        guard let dict = try? comment.toDictionary() else {return}
        
        Ref.FIRESTORE_COMMENTS_DOCUMENT_POSTID(postId: postId).collection("postComments").addDocument(data: dict) { (error) in
            if let error = error {
                onError(error.localizedDescription)
                return
            }
            onSuccess()
        }
    }
}
