//
//  SessionStore.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/7/20.
//

import Foundation
import Combine
import FirebaseAuth

class SessionStore: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var userSession: User?
    var handle: AuthStateDidChangeListenerHandle?
    
    func listenAuthenticationState() {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                
                let firestoreUid = Ref.FIRESTORE_DOCUMENT_USERID(userId: user.uid)
                firestoreUid.getDocument { (document, error) in
                    if let dict = document?.data(){
                        var dictionary = dict
                        dictionary["uid"] = document!.documentID
                        guard let decodeUser = try? User.init(fromDictionary: dictionary) else {return}
                        self.userSession = decodeUser
                        print("email: \(self.userSession!.email)")
                    }
                }
                self.isLoggedIn = true
                
            }else{
                print("user is logged out")
                self.isLoggedIn = false
                self.userSession = nil
            }
        })
    }
    
    func logout(){
        do {
            try Auth.auth().signOut()
        }catch{
            print("error when logging out")
        }
    }
    
    func unbind(){
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit{
        unbind()
    }
}
