//
//  TweetViewModel.swift
//  SpinTweet
//
//  Created by sangam pokharel on 27/05/2024.
//

import Foundation
import Firebase

class TweetViewModel:BaseViewModel {
    
    var tweetText:String = ""
    func uploadTweet(completition:(()->())?) {
        if tweetText.isEmpty {
            self.showValidationError(error: "Tweet must not be empty! ")
            return
        }
        isLoading = true
        let user = AuthStateViewModel.shared.user
        guard let user else {return}
        let docRef = Firestore.firestore().collection("tweets").document()
        let tweet:[String:Any] = [
            "uid":user.currentUserId,
            "caption":tweetText,
            "fullname":user.fullName,
            "timestamp": Timestamp(date: Date()),
            "username": user.userName,
            "profileImageUrl":user.profileUrl,
            "likes":0,
            "id": docRef.documentID
        ]
        docRef.setData(tweet) { _ in
            self.isLoading = false
            completition?()
        }
    }
    
    
}
