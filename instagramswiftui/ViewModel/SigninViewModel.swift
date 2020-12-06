//
//  SigninViewModel.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/6/20.
//

import Foundation

import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage
import SwiftUI

class SigninViewModel: ObservableObject {
    
     var email: String = ""
     var password: String = ""
     var imageData: Data = Data()
     var errorString = ""
     @Published var showImagePicker: Bool = false
     @Published var showAlert: Bool = false

    func signin(email: String, password: String, completed: @escaping(_ user: User) -> Void,  onError: @escaping(_ errorMessage: String) -> Void) {
        if !email.isEmpty && !password.isEmpty {
           AuthService.signinUser(email: email, password: password, onSuccess: completed, onError: onError)
        } else {
            showAlert = true
            errorString = "Please fill in all fields"
        }
    }
}
