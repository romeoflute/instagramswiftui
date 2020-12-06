//
//  StorageService.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/6/20.
//

import Foundation
import Firebase

class StorageService {
    static func saveAvatar(userId: String, username: String, email: String, imageData: Data, metadata: StorageMetadata, storageAvatarRef: StorageReference, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
           storageAvatarRef.putData(imageData, metadata: metadata) { (storageMetadata, error) in
                if error != nil {
                    onError(error!.localizedDescription)
                    return
                }
                
                storageAvatarRef.downloadURL { (url, error) in
                    if let metaImageUrl = url?.absoluteString {
                        if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                            changeRequest.photoURL = url
                            changeRequest.displayName = username
                            changeRequest.commitChanges { (error) in
                                if error != nil {
                                   onError(error!.localizedDescription)
                                   return
                                }
                            }
                        }
                                                    
                        let firestoreUserId = Ref.FIRESTORE_DOCUMENT_USERID(userId: userId)
                        let user = User.init(uid: userId, email: email, profileImageUrl: metaImageUrl, username: username, bio: "", keywords: [])
                        guard let dict = try? user.toDictionary() else {return}
                        
                        firestoreUserId.setData(dict) { (error) in
                            if error != nil {
                                onError(error!.localizedDescription)
                                return
                            }
                            onSuccess(user)
                        }
                    }
                }
                
            }
    }
}
