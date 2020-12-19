//
//  ChatViewModel.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/19/20.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage
import SwiftUI


class ChatViewModel: ObservableObject {
    
    @Published var composedMessage: String = ""
    var imageData: Data = Data()
    var errorString = ""
    var image: Image = Image(systemName: IMAGE_PHOTO)
    @Published var showAlert: Bool = false
    @Published var showImagePicker: Bool = false
    
    @Published var chatArray: [Chat] = []
    @Published var isLoading = false
    var recipientId = ""
    var listener: ListenerRegistration!
    
    func loadChatMessages() {
        self.chatArray = []
        self.isLoading = true
        
        Api.Chat.getChatMessages(withUser: recipientId, onSuccess: { (chatMessages) in
            if self.chatArray.isEmpty {
                self.chatArray = chatMessages
            }
        }, onError: { (errorMessage) in
            
        }, newChatMessage: { (chat) in
            if !self.chatArray.isEmpty {
                self.chatArray.append(chat)
            }
        }) { (listener) in
            self.listener = listener
        }
    }
   
    func sendTextMessage(recipientId: String, recipientAvatarUrl: String, recipientUsername: String, completed: @escaping() -> Void,  onError: @escaping(_ errorMessage: String) -> Void) {
        if !composedMessage.isEmpty {
            Api.Chat.sendMessages(message: composedMessage, recipientId: recipientId, recipientAvatarUrl: recipientAvatarUrl, recipientUsername: recipientUsername, onSuccess: completed, onError: onError)
          } else {
              showAlert = true
              errorString = "Please fill in all fields"
          }
    }
    
    func sendPhotoMessage(recipientId: String, recipientAvatarUrl: String, recipientUsername: String, completed: @escaping() -> Void,  onError: @escaping(_ errorMessage: String) -> Void) {
          if !imageData.isEmpty {
            Api.Chat.sendPhotoMessages(recipientId: recipientId, recipientAvatarUrl: recipientAvatarUrl, recipientUsername: recipientUsername, imageData: imageData, onSuccess: completed, onError: onError)

          } else {
              showAlert = true
              errorString = "Please fill in all fields"
          }
    }
    
}
