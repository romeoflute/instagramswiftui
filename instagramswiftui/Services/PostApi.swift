//
//  PostApi.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/15/20.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import Firebase

class PostApi {
    func uploadPost(caption: String, imageData: Data, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let postId = Ref.FIRESTORE_MY_POSTS_DOCUMENT_USERID(userId: userId).collection("userPosts").document().documentID
        let storagePostRef = Ref.STORAGE_POST_ID(postId: postId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        StorageService.savePostPhoto(userId: userId, caption: caption, postId: postId, imageData: imageData, metadata: metadata, storagePostRef: storagePostRef, onSuccess: onSuccess, onError: onError)
        
    }
    
    func loadPosts(onSuccess: @escaping(_ posts: [Post]) -> Void) {
        Ref.FIRESTORE_COLLECTION_ALL_POSTS.order(by: "likeCount", descending: true).getDocuments { (snapshot, error) in
            guard let snap = snapshot else {
                print("Error fetching data")
                return
            }
            var posts = [Post]()
            for document in snap.documents {
                let dict = document.data()
                guard let decoderPost = try? Post.init(fromDictionary: dict) else {return}
                posts.append(decoderPost)
                
                
            }
            onSuccess(posts)
        }
    }
    
    func loadTimeline(onSuccess: @escaping(_ posts: [Post]) -> Void, newPost: @escaping(Post) -> Void, deletePost: @escaping(Post) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
                return
        }
        let listenerFirestore =  Ref.FIRESTORE_TIMELINE_DOCUMENT_USERID(userId: userId).collection("timelinePosts").order(by: "date", descending: true).addSnapshotListener({ (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                   return
            }
            
            snapshot.documentChanges.forEach { (documentChange) in
                  switch documentChange.type {
                  case .added:
                      var posts = [Post]()
                      print("type: added")
                      let dict = documentChange.document.data()
                      guard let decoderPost = try? Post.init(fromDictionary: dict) else {return}
                      newPost(decoderPost)
                      posts.append(decoderPost)
                      onSuccess(posts)
                  case .modified:
                      print("type: modified")
                  case .removed:
                      print("type: removed")
                      let dict = documentChange.document.data()
                       guard let decoderPost = try? Post.init(fromDictionary: dict) else {return}
                       deletePost(decoderPost)
                  }
            }
        })
        listener(listenerFirestore)
    }
}
