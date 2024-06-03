//
//  Message.swift
//  SpinTweet
//
//  Created by sangam pokharel on 29/05/2024.
//

import Foundation
import Firebase

struct Message:Identifiable {
    let text:String
    let user:User
    let toId:String
    let fromId:String
    let isFromCurrentUser:Bool
    let timestamp:Timestamp
    let id:String
    
    var chatPartnerId:String {
        return isFromCurrentUser ? toId : fromId
    }
    
    var dateFormat: String {
        let date = timestamp.dateValue()
        let now = Date()
        
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        
        let relativeDate = formatter.localizedString(for: date, relativeTo: now)
        return relativeDate
    }
    
    init(user:User,dictionary:[String:Any]){
        self.user = user
        self.text = dictionary["text"] as? String ?? ""
        self.toId = dictionary["toId"] as? String ?? ""
        self.fromId = dictionary["fromId"] as? String ?? ""
        self.isFromCurrentUser = fromId == Auth.auth().currentUser?.uid
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.id = dictionary["id"] as? String ?? ""
    }
    
    
}
