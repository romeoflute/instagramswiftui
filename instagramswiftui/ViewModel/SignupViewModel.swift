//
//  SignupViewModel.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/6/20.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage
import SwiftUI

class SignupViewModel: ObservableObject {
    
     var username: String = ""
     var email: String = ""
     var password: String = ""
     var image: Image = Image(IMAGE_USER_PLACEHOLDER)
     var imageData: Data = Data()
     var errorString = ""
     @Published var showImagePicker: Bool = false
     @Published var showAlert: Bool = false
    
    
    func signup(username: String, email: String, password: String, imageData: Data, completed: @escaping(_ user: User) -> Void,  onError: @escaping(_ errorMessage: String) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (authData, error) in
            if error != nil {
                print("error encountered: \(error?.localizedDescription ?? "")")
                return
            }
            let storageRoot = Storage.storage().reference(forURL: "gs://instagramswiftui-103e5.appspot.com")
            let storageAvatar = storageRoot.child("avatar")
            
            guard let userId = authData?.user.uid else {return}
            let storageAvatarUserId = storageAvatar.child(userId)
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            storageAvatarUserId.putData(imageData, metadata: metadata) { (storageMetadata, error) in
                if error != nil {
                    print("error encountered: \(error?.localizedDescription ?? "")")
                    return
                }
                storageAvatarUserId.downloadURL { (url, error) in
                    if let metaImageUrl = url?.absoluteString{
                        if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest(){
                            changeRequest.photoURL = url
                            changeRequest.displayName = self.username
                            changeRequest.commitChanges { (error) in
                                if error != nil {
                                    print("error encountered: \(error?.localizedDescription ?? "")")
                                    return
                                }
                                print("successfully updated image")
                            }
                            
                            let firestoreUserId = Ref.FIRESTORE_DOCUMENT_USERID(userId: userId)
                            
                            let user = User.init(uid: userId, email: email, profileImageUrl: metaImageUrl, username: username, bio: "", keywords: [])
                            guard let dict = try? user.toDictionary() else {return}
                            
                            
                            firestoreUserId.setData(dict)
                        }
                    }
                }
            }
        }
    }
//
//    func signup(username: String, email: String, password: String, imageData: Data, completed: @escaping(_ user: User) -> Void,  onError: @escaping(_ errorMessage: String) -> Void) {
//        if !username.isEmpty && !email.isEmpty && !password.isEmpty && !imageData.isEmpty {
//           AuthService.signupUser(username: username, email: email, password: password, imageData: imageData, onSuccess: completed, onError: onError)
//        } else {
//            showAlert = true
//            errorString = "Please fill in all fields"
//        }
//    }
}

