//
//  FollowViewModel.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/20/20.
//

import Foundation

class FollowViewModel: ObservableObject {
    
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
    
    func handleFollow(userId: String, followingCount_onSuccess: @escaping(_ followingCount: Int) -> Void, followersCount_onSuccess: @escaping(_ followersCount: Int) -> Void ) {
        if !isFollowing {
            follow(userId: userId, followingCount_onSuccess: followingCount_onSuccess, followersCount_onSuccess: followersCount_onSuccess)
            isFollowing = true
        } else {
            unfollow(userId: userId, followingCount_onSuccess: followingCount_onSuccess, followersCount_onSuccess: followersCount_onSuccess)
            isFollowing = false
        }
    }
    
    
    func follow(userId: String, followingCount_onSuccess: @escaping(_ followingCount: Int) -> Void, followersCount_onSuccess: @escaping(_ followersCount: Int) -> Void ) {
        Ref.FIRESTORE_COLLECTION_FOLLOWING_USERID(userId: userId).setData([:]) { (error) in
            if error == nil {
                self.updateFollowCount(userId: userId, followingCount_onSuccess: followingCount_onSuccess, followersCount_onSuccess: followersCount_onSuccess)
            }
        }
        
        Ref.FIRESTORE_COLLECTION_FOLLOWERS_USERID(userId: userId).setData([:]) { (error) in
            if error == nil {
                self.updateFollowCount(userId: userId, followingCount_onSuccess: followingCount_onSuccess, followersCount_onSuccess: followersCount_onSuccess)
            }
        }
    }
    
    func unfollow(userId: String, followingCount_onSuccess: @escaping(_ followingCount: Int) -> Void, followersCount_onSuccess: @escaping(_ followersCount: Int) -> Void ) {
        Ref.FIRESTORE_COLLECTION_FOLLOWING_USERID(userId: userId).getDocument { (document, error) in
            if let doc = document, doc.exists {
                doc.reference.delete()
                self.updateFollowCount(userId: userId, followingCount_onSuccess: followingCount_onSuccess, followersCount_onSuccess: followersCount_onSuccess)
            }
        }
        
        Ref.FIRESTORE_COLLECTION_FOLLOWERS_USERID(userId: userId).getDocument { (document, error) in
              if let doc = document, doc.exists {
                  doc.reference.delete()
                  self.updateFollowCount(userId: userId, followingCount_onSuccess: followingCount_onSuccess, followersCount_onSuccess: followersCount_onSuccess)
              }
          }
    }
    
    func updateFollowCount(userId: String, followingCount_onSuccess: @escaping(_ followingCount: Int) -> Void, followersCount_onSuccess: @escaping(_ followersCount: Int) -> Void  ) {
        Ref.FIRESTORE_COLLECTION_FOLLOWING(userId: userId).getDocuments { (snapshot, error) in
            if let doc = snapshot?.documents {
                followingCount_onSuccess(doc.count)
            }
        }
        Ref.FIRESTORE_COLLECTION_FOLLOWERS(userId: userId).getDocuments { (snapshot, error) in
             if let doc = snapshot?.documents {
                followersCount_onSuccess(doc.count)
             }
         }
    }
}
