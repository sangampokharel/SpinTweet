//
//  HomeViewModel.swift
//  SpinTweet
//
//  Created by sangam pokharel on 27/05/2024.
//

import Foundation
import Firebase

class HomeViewModel:BaseViewModel {
    
    @Published var tweets:[TweetModel] = []
    
    let authStateViewModel = AuthStateViewModel.shared
    
    static let shared = HomeViewModel()
    
    override init() {
        super.init()
        fetchTweets()
    }
    
    func fetchTweets(){
        isLoading = true
        Firestore.firestore().collection("tweets").order(by: "timestamp",descending: true).getDocuments { snapshot, _ in
            let data = snapshot?.documents
            let tweets = data?.map({
                TweetModel(tweet: $0.data())
            }) ?? []
            self.tweets = tweets
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                self.checkIfAlreadyLikedTweet()
            }
        }
    }
    
    func likeTweets(tweet:TweetModel) {
        isLoading = true
        let tweetRef = Firestore.firestore().collection("tweets").document(tweet.id)
        tweetRef.updateData(["likes": tweet.likes + 1]) {[weak self] _ in
            guard let userId = self?.authStateViewModel.user?.currentUserId else {return}
            tweetRef.collection("tweet-likes").document(userId).setData([:]) {[weak self] _ in
                let userRef = Firestore.firestore().collection("users").document(userId).collection("user-liked-tweets").document(tweet.id)
                userRef.setData([:]) { [weak self] _ in
                    guard let `self` else {return}
                    if let index = self.tweets.firstIndex(where: { $0.id == tweet.id }) {
                        self.tweets[index].likes += 1
                        self.tweets[index].hasLiked = true
                    }
                    isLoading = false
                }
            }
        }
    }
    
    func unLikeTweet(tweet:TweetModel){
        isLoading = true
        let tweetRef = Firestore.firestore().collection("tweets").document(tweet.id)
        tweetRef.updateData(["likes":tweet.likes - 1]) {[weak self] _ in
            guard let userId = self?.authStateViewModel.user?.currentUserId else {return}
            tweetRef.collection("tweet-likes").document(userId).delete { _ in
                Firestore.firestore().collection("users").document(userId).collection("user-liked-tweets").document(tweet.id).delete { _ in
                    guard let `self` else {return}
                    if let index = self.tweets.firstIndex(where: { $0.id == tweet.id }) {
                        self.tweets[index].likes -= 1
                        self.tweets[index].hasLiked = false
                    }
                    self.isLoading = false
                }
            }
            
        }
    }
    
    
    func checkIfAlreadyLikedTweet(){
        guard let userId = authStateViewModel.user?.currentUserId else {return}
        Firestore.firestore().collection("users").document(userId).collection("user-liked-tweets").getDocuments { snapshot, _ in
            if let likedTweets = snapshot?.documents {
                for item in likedTweets {
                    if let index = self.tweets.firstIndex(where:{$0.id == item.documentID}) {
                        self.tweets[index].hasLiked = true
                    }
                }
                self.isLoading = false
            }
        }
    }
    
    
    
    
}
