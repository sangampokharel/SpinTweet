//
//  ProfileViewModel.swift
//  SpinTweet
//
//  Created by sangam pokharel on 24/05/2024.
//

import Foundation
import Firebase

class ProfileViewModel:BaseViewModel {
    @Published var isFollowing = false
    @Published var user:User
    
    init(user:User){
        self.user = user
        super.init()
        self.checkIfAlreadyFollowed()
        
    }
    
    func followUser() {
        isLoading = true
        Firestore.firestore().collection("Following").document(user.currentUserId).collection("user-following").document(user.id).setData([:]){ _ in
            Firestore.firestore().collection("Followers").document(self.user.id).collection("user-followers").document(self.user.currentUserId).setData([:]){ _ in
                self.isFollowing = true
                self.getFollowsCount()
            }
        }
    }
    
    func unFollowUser(){
        isLoading = true
        Firestore.firestore().collection("Following").document(user.currentUserId).collection("user-following").document(user.id).delete { _ in
            Firestore.firestore().collection("Followers").document(self.user.id).collection("user-followers").document(self.user.currentUserId).delete { _ in
                self.isFollowing = false
                self.getFollowsCount()
            }
        }
    }
    
    func checkIfAlreadyFollowed(){
        isLoading = true
        let userDocument = Firestore.firestore().collection("Following").document(user.currentUserId).collection("user-following").document(user.id)
        userDocument.getDocument { snapshot, _ in
            if let doesExist = snapshot?.exists {
                self.isFollowing = doesExist
                self.getFollowsCount()
            }
        }
    }
    
    func getFollowsCount(){
        Firestore.firestore().collection("Following").document(user.id).collection("user-following").getDocuments { snapshot, _ in
            let followingCount = snapshot?.count
            Firestore.firestore().collection("Followers").document(self.user.id).collection("user-followers").getDocuments { snapshot, _ in
                let followersCount = snapshot?.count
                self.user.userStats = UserStats(followers: followersCount ?? 0 , following: followingCount ?? 0)
                self.isLoading = false
            }
        }
        
       
      
    }
}
