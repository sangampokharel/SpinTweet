//
//  ChatViewModel.swift
//  SpinTweet
//
//  Created by sangam pokharel on 29/05/2024.
//

import Foundation
import Firebase

class ChatViewModel:BaseViewModel {
    
    var user:User?
    @Published var messages = [Message]()
    
    init(user: User) {
        super.init()
        self.user = user
        fetchMessages()
    }
    
    
    func fetchMessages(){
        guard let currentUID =  AuthStateViewModel.shared.user?.currentUserId else {return}
        guard let id = user?.id else {return}
        let messageRef = Firestore.firestore().collection("messages").document(currentUID).collection(id)
//        messageRef.order(by: "timestamp",descending: true)
        messageRef.addSnapshotListener { snapshot, error in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added}) else {return}
            changes.forEach { change in
                let messageData = change.document.data()
                guard let fromId = messageData["fromId"] as? String else {return}
                Firestore.firestore().collection("users").document(fromId).getDocument { snapshot, _ in
                    guard let data = snapshot?.data() else {return}
                    let user = User(user: data)
                    self.messages.append(Message(user: user, dictionary: messageData))
                    self.messages.sort(by: {$0.timestamp.dateValue() < $1.timestamp.dateValue()})
                }
            }
        }
    }
    
    func sendMessage(messageText:String) {
        guard let currentUserId = user?.currentUserId else {return}
        guard let id = user?.id else {return}
        let currentUserRef = Firestore.firestore().collection("messages").document(currentUserId).collection(id).document()
        let recevingUserRef = Firestore.firestore().collection("messages").document(id).collection(currentUserId)
        
        let receivingRecentRef = Firestore.firestore().collection("messages").document(id).collection("recent-messages")
        let currentRecentRef = Firestore.firestore().collection("messages").document(currentUserId).collection("recent-messages")
        
        let messageID = currentUserRef.documentID
        
        let data:[String:Any] = [
            "text":messageText,
            "id":messageID,
            "fromId":currentUserId,
            "toId":id,
            "timestamp":Timestamp(date: Date())
        
        ]
        
        currentUserRef.setData(data)
        recevingUserRef.document(messageID).setData(data)
        receivingRecentRef.document(currentUserId).setData(data)
        currentRecentRef.document(id).setData(data)
    }
    
}
