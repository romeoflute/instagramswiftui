//
//  FooterCellViewModel.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/18/20.
//

import Foundation
import SwiftUI
import FirebaseAuth

class FooterCellViewModel: ObservableObject {
    
    @Published var post: Post!
    @Published var isLoading = false
    @Published var isLiked = false
    
    func checkPostIsLiked(){
        isLiked = (post.likes["\(Auth.auth().currentUser!.uid)"] == true ) ? true : false
    }

    func like() {
        post.likeCount += 1
        isLiked = true
        
        Ref.FIRESTORE_MY_POSTS_DOCUMENT_USERID(userId: post.ownerId).collection("userPosts").document(post.postId).updateData(["likes.\(Auth.auth().currentUser!.uid)" : true, "likeCount":  post.likeCount])
        Ref.FIRESTORE_COLLECTION_ALL_POSTS.document(post.postId).updateData(["likes.\(Auth.auth().currentUser!.uid)" : true, "likeCount":  post.likeCount])
        Ref.FIRESTORE_TIMELINE_DOCUMENT_USERID(userId: post.ownerId).collection("timelinePosts").document(post.postId).updateData(["likes.\(Auth.auth().currentUser!.uid)" : true, "likeCount":  post.likeCount])
    }
    
    func unlike() {
        post.likeCount -= 1
        isLiked = false
        
        Ref.FIRESTORE_MY_POSTS_DOCUMENT_USERID(userId: post.ownerId).collection("userPosts").document(post.postId).updateData(["likes.\(Auth.auth().currentUser!.uid)" : false,
                                                                                                                                  "likeCount":  post.likeCount])
        Ref.FIRESTORE_COLLECTION_ALL_POSTS.document(post.postId).updateData(["likes.\(Auth.auth().currentUser!.uid)" : false,
                                                                                "likeCount":  post.likeCount])
        Ref.FIRESTORE_TIMELINE_DOCUMENT_USERID(userId: post.ownerId).collection("timelinePosts").document(post.postId).updateData(["likes.\(Auth.auth().currentUser!.uid)" : false,
                                                                                                                                      "likeCount":  post.likeCount])
    }
}
