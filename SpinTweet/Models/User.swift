//
//  User.swift
//  SpinTweet
//
//  Created by sangam pokharel on 24/05/2024.
//

import Foundation
import Firebase
struct User:Identifiable {
    var id:String
    var fullName:String
    var userName:String
    var email:String
    var profileUrl:String
    var userStats:UserStats = UserStats(followers: 0, following: 0)
    var currentUserId:String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    var isCurrentUser: Bool {
        return id == Auth.auth().currentUser?.uid
    }
    
    init(user:[String:Any]) {
        self.id = user["uid"] as! String
        self.fullName = user["fullName"]  as! String
        self.userName = user["userName"]  as! String
        self.email = user["email"]  as! String
        self.profileUrl = user["profileImageUrl"]  as! String
    }
}

struct UserStats {
    var followers:Int
    var following:Int
}
