//
//  ProfileViewModel.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/20/20.
//

import Foundation
import SwiftUI
import FirebaseAuth
class ProfileViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var followersCountState = 0
    @Published var followingCountState = 0

    var splitted: [[Post]] = []
    
    
    @Published var isFollowing = false
    
    func checkFollow(userId: String) {
        Ref.FIRESTORE_COLLECTION_FOLLOWERS_USERID(userId: userId).getDocument { (document, error) in
            if let doc = document, doc.exists {
                self.isFollowing = true
            } else {
                self.isFollowing = false
            }
        }
    }
    
    func loadUserPosts(userId: String) {
        isLoading = true
        Api.User.loadPosts(userId: userId) { (posts) in
            self.isLoading = false
            self.posts = posts
            self.splitted = self.posts.splited(into: 3)
        }
        checkFollow(userId: userId)
        updateFollowCount(userId: userId)
    }
    
    func updateFollowCount(userId: String) {
                        
        Ref.FIRESTORE_COLLECTION_FOLLOWING(userId: userId ).getDocuments { (snapshot, error) in
            
            if let doc = snapshot?.documents {
                self.followingCountState = doc.count
            }
        }
        
        Ref.FIRESTORE_COLLECTION_FOLLOWERS(userId: userId).getDocuments { (snapshot, error) in
             if let doc = snapshot?.documents {
                self.followersCountState = doc.count
             }
         }
    }
}
