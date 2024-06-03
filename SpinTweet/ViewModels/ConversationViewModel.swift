//
//  ConversationViewModel.swift
//  SpinTweet
//
//  Created by sangam pokharel on 30/05/2024.
//

import Foundation
import Firebase

class ConversationViewModel:BaseViewModel {
    
    @Published var recentMessages = [Message]()
    private var recentMeesageDictornary = [String:Message]()
    private var listener: ListenerRegistration?
    
    override init() {
        super.init()
    }
    
    func fetchRecentMessages(){
        isLoading = true
        guard let currentUID =  AuthStateViewModel.shared.user?.currentUserId else {return}
        let messageRef = Firestore.firestore().collection("messages").document(currentUID).collection("recent-messages")
        messageRef.order(by: "timestamp",descending: true)
        listener?.remove()
        listener = messageRef.addSnapshotListener { snapshot, error in
            guard let changes = snapshot?.documentChanges else {return}
            changes.forEach { change in
                let messageData = change.document.data()
                let uid = change.document.documentID
                Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
                    guard let data = snapshot?.data() else {return}
                    let user = User(user: data)
                    self.recentMeesageDictornary[uid] = Message(user: user, dictionary: messageData)
                    self.recentMessages = Array(self.recentMeesageDictornary.values)
                    self.isLoading = false
                }
            }
        }
    }
    
    func stopListening() {
           listener?.remove()
           listener = nil
       }
    
    
}
