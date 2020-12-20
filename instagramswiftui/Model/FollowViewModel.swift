//
//  FollowViewModel.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/20/20.
//

import Foundation

class FollowViewModel: ObservableObject {
    
    func follow(userId: String) {
        Ref.FIRESTORE_COLLECTION_FOLLOWING_USERID(userId: userId).setData([:]) { (error) in
            if error == nil {
                self.updateFollowCount(userId: userId)
            }
        }
        
        Ref.FIRESTORE_COLLECTION_FOLLOWERS_USERID(userId: userId).setData([:]) { (error) in
            if error == nil {
                self.updateFollowCount(userId: userId)
            }
        }
    }
    
    func unfollow(userId: String) {
        Ref.FIRESTORE_COLLECTION_FOLLOWING_USERID(userId: userId).getDocument { (document, error) in
            if let doc = document, doc.exists {
                doc.reference.delete()
                self.updateFollowCount(userId: userId)
            }
        }
        
        Ref.FIRESTORE_COLLECTION_FOLLOWERS_USERID(userId: userId).getDocument { (document, error) in
              if let doc = document, doc.exists {
                  doc.reference.delete()
                  self.updateFollowCount(userId: userId)
              }
          }
    }
    
    func updateFollowCount(userId: String) {
        Ref.FIRESTORE_COLLECTION_FOLLOWING(userId: userId).getDocuments { (snapshot, error) in
            if let doc = snapshot?.documents {
                print("following count : \(doc.count)")
            }
        }
        
        Ref.FIRESTORE_COLLECTION_FOLLOWERS(userId: userId).getDocuments { (snapshot, error) in
             if let doc = snapshot?.documents {
                 print("followers count : \(doc.count)")
             }
         }
    }
    
}
