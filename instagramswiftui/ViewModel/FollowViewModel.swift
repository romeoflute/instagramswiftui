//
//  FollowViewModel.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/20/20.
//

import Foundation
import FirebaseAuth

class FollowViewModel: ObservableObject {
    
    func handleFollow(userId: String, isFollowing: Bool, followingCount_onSuccess: @escaping(_ followingCount: Int) -> Void, followersCount_onSuccess: @escaping(_ followersCount: Int) -> Void ) {
        if !isFollowing {
            follow(userId: userId, followingCount_onSuccess: followingCount_onSuccess, followersCount_onSuccess: followersCount_onSuccess)
        } else {
            unfollow(userId: userId, followingCount_onSuccess: followingCount_onSuccess, followersCount_onSuccess: followersCount_onSuccess)
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
        
        let activityId = Ref.FIRESTORE_COLLECTION_ACTIVITY.document(userId).collection("feedItems").document().documentID
        let activityObject = Activity(activityId: activityId, type: "follow", username: Auth.auth().currentUser!.displayName!, userId: Auth.auth().currentUser!.uid, userAvatar: Auth.auth().currentUser!.photoURL!.absoluteString, postId: "", mediaUrl: "", comment: "", date: Date().timeIntervalSince1970)
        guard let activityDict = try? activityObject.toDictionary() else { return }
        
        Ref.FIRESTORE_COLLECTION_ACTIVITY.document(userId).collection("feedItems").document(activityId).setData(activityDict)
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
        
        Ref.FIRESTORE_COLLECTION_ACTIVITY.document(userId).collection("feedItems").whereField("type", isEqualTo: "follow").whereField("userId", isEqualTo: Auth.auth().currentUser!.uid).getDocuments { (snapshot, error) in
            if let doc = snapshot?.documents {
                if let data = doc.first, data.exists {
                    data.reference.delete()
                }
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
