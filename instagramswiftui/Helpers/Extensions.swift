//
//  Extensions.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/6/20.
//

import SwiftUI
import Firebase
import FirebaseStorage

extension Array {
    func splited(into size:Int) -> [[Element]] {
        
        var splittedArray = [[Element]]()
        
        for index in 0...self.count {
            if index % size == 0 && index != 0 {
                splittedArray.append(Array(self[(index - size)..<index]))
            } else if(index == self.count) {
                splittedArray.append(Array(self[index - 1..<index]))
            }
        }
        
        return splittedArray
    }
}


extension Encodable {
    func toDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}

extension Decodable {
    init(fromDictionary: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: fromDictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: data)
    }
}

class Ref {
    // Storage
    static var STORAGE_ROOT = Storage.storage().reference(forURL: "gs://swiftui-instagram.appspot.com")
    static var STORAGE_AVATAR = STORAGE_ROOT.child("avatar")
    static func STORAGE_AVATAR_USERID(userId: String) -> StorageReference {
        return STORAGE_AVATAR.child(userId)
    }
    
    // Firestore
    static var FIRESTORE_ROOT = Firestore.firestore()
    static var FIRESTORE_COLLECTION_USERS = FIRESTORE_ROOT.collection("users")
    static func FIRESTORE_DOCUMENT_USERID(userId: String) -> DocumentReference {
        return FIRESTORE_COLLECTION_USERS.document(userId)
    }
}

extension Color {
    
    static let instagram: [Color] = [
        Color(red: 64 / 255, green: 93 / 255, blue: 230 / 255),
        Color(red: 88 / 255, green: 81 / 255, blue: 219 / 255),
        Color(red: 131 / 255, green: 58 / 255, blue: 180 / 255),
        Color(red: 193 / 255, green: 53 / 255, blue: 132 / 255),
        Color(red: 225 / 255, green: 48 / 255, blue: 108 / 255),
        Color(red: 253 / 255, green: 29 / 255, blue: 29 / 255),
        Color(red: 245 / 255, green: 96 / 255, blue: 64 / 255),
        Color(red: 247 / 255, green: 119 / 255, blue: 55 / 255),
        Color(red: 252 / 255, green: 175 / 255, blue: 69 / 255),
        Color(red: 255 / 255, green: 220 / 255, blue: 128 / 255),
        Color(red: 64 / 255, green: 93 / 255, blue: 230 / 255)
    ]
}
