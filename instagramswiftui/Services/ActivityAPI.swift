//
//  ActivityAPI.swift
//  instagramswiftui
//
//  Created by Romeo Flauta on 12/22/20.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import Firebase

class ActivityApi {
    
    func loadActivities(onSuccess: @escaping(_ activityArray: [Activity]) -> Void, newActivity: @escaping(Activity) -> Void, deleteActivity: @escaping(Activity) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
                return
        }
        let listenerFirestore =  Ref.FIRESTORE_COLLECTION_ACTIVITY.document(userId).collection("feedItems").order(by: "date", descending: false).addSnapshotListener({ (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                   return
            }
            
            snapshot.documentChanges.forEach { (documentChange) in
                  switch documentChange.type {
                  case .added:
                    var activityArray = [Activity]()
                      print("type: added")
                      let dict = documentChange.document.data()
                      guard let decoderActivity = try? Activity.init(fromDictionary: dict) else {return}
                      newActivity(decoderActivity)
                      activityArray.append(decoderActivity)
                      onSuccess(activityArray)
                  case .modified:
                      print("type: modified")
                  case .removed:
                      print("type: removed")
                      let dict = documentChange.document.data()
                       guard let decoderActivity = try? Activity.init(fromDictionary: dict) else {return}
                       deleteActivity(decoderActivity)
                  }
            }
        })
        
        listener(listenerFirestore)
    }
}
