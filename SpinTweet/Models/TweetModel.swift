//
//  Tweet.swift
//  SpinTweet
//
//  Created by sangam pokharel on 27/05/2024.
//

import Foundation
import Firebase
struct TweetModel:Identifiable {
    var id:String
    var caption:String
    var username:String
    var uid:String
    var fullname:String
    var timestamp:Timestamp
    var likes:Int
    var profileImageUrl:String
    var hasLiked:Bool = false
    
    var dateFormat: String {
        let date = timestamp.dateValue()
        let now = Date()
        
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        
        let relativeDate = formatter.localizedString(for: date, relativeTo: now)
        return relativeDate
    }
    init(tweet:[String:Any]){
        self.id = tweet["id"] as? String ?? ""
        self.caption = tweet["caption"] as? String ?? ""
        self.username = tweet["username"] as? String ?? ""
        self.uid = tweet["uid"] as? String ?? ""
        self.fullname = tweet["fullname"] as? String ?? ""
        self.timestamp = tweet["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.likes = tweet["likes"] as? Int ?? 0
        self.profileImageUrl = tweet["profileImageUrl"] as? String ?? ""
    }
    
}
