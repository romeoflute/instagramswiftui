//
//  ChatAPI.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/19/20.
//

import Foundation

import Foundation
import FirebaseAuth
import FirebaseStorage
import Firebase

class ChatApi {
    func sendMessages(message: String, recipientId: String, recipientAvatarUrl: String, recipientUsername: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        guard let senderId = Auth.auth().currentUser?.uid else { return }
        guard let senderUsername = Auth.auth().currentUser?.displayName else { return }
        guard let senderAvatarUrl = Auth.auth().currentUser?.photoURL!.absoluteString else { return }
        
        let messageId = Ref.FIRESTORE_COLLECTION_CHATROOM(senderId: senderId, recipientId: recipientId).document().documentID
        let chat = Chat(messageId: messageId, textMessage: message, avatarUrl: senderAvatarUrl, photoUrl: "", senderId: senderId, username: senderUsername, date: Date().timeIntervalSince1970)
        
        guard let dict = try? chat.toDictionary() else { return }
        
        Ref.FIRESTORE_COLLECTION_CHATROOM(senderId: senderId, recipientId: recipientId).document(messageId).setData(dict) { (error) in
            if error == nil {
                 Ref.FIRESTORE_COLLECTION_CHATROOM(senderId: recipientId, recipientId: senderId).document(messageId).setData(dict)
                
                let inboxMessage1 = InboxMessage(lastMessage: message, username: recipientUsername, type: "TEXT", date: Date().timeIntervalSince1970, userId: recipientId, avatarUrl: recipientAvatarUrl)
                let inboxMessage2 = InboxMessage(lastMessage: message, username: senderUsername, type: "TEXT", date: Date().timeIntervalSince1970, userId: senderId, avatarUrl: senderAvatarUrl)

                guard let inboxDict1 = try? inboxMessage1.toDictionary() else { return }
                guard let inboxDict2 = try? inboxMessage2.toDictionary() else { return }

                Ref.FIRESTORE_COLLECTION_INBOX_MESSAGES_DOCUMENT_USERID(senderId: senderId, recipientId: recipientId).setData(inboxDict1)
                Ref.FIRESTORE_COLLECTION_INBOX_MESSAGES_DOCUMENT_USERID(senderId: recipientId, recipientId: senderId).setData(inboxDict2)
                onSuccess()
            } else {
                onError(error!.localizedDescription)
            }
        }
    }
    
    func sendPhotoMessages(recipientId: String, recipientAvatarUrl: String, recipientUsername: String, imageData: Data, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        guard let senderId = Auth.auth().currentUser?.uid else { return }
        guard let senderUsername = Auth.auth().currentUser?.displayName else { return }
        guard let senderAvatarUrl = Auth.auth().currentUser?.photoURL!.absoluteString else { return }
        
        let messageId = Ref.FIRESTORE_COLLECTION_CHATROOM(senderId: senderId, recipientId: recipientId).document().documentID
        
        let storageChatRef = Ref.STORAGE_CHAT_ID(chatId: messageId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        StorageService.saveChatPhoto(messageId: messageId, senderId: senderId, senderUsername: senderUsername, senderAvatarUrl: senderAvatarUrl, recipientId: recipientId, recipientAvatarUrl: recipientAvatarUrl, recipientUsername: recipientUsername, imageData: imageData, metadata: metadata, storageChatRef: storageChatRef, onSuccess: onSuccess, onError: onError)
    }
}

