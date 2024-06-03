//
//  SearchViewModel.swift
//  SpinTweet
//
//  Created by sangam pokharel on 24/05/2024.
//

import Foundation
import Firebase

class SearchViewModel:BaseViewModel {
    
    @Published var users:[User] = []
    @Published var filteredUsers:[User] = []
    
    static let shared = SearchViewModel()
    
    override init() {
        super.init()
        fetchUsers()
    }
    
    private func fetchUsers(){
        isLoading = true
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            if let error {
                self.isLoading = false
                self.showValidationError(error: error.localizedDescription)
                return
            }
            
            guard let documents = snapshot?.documents else {return}
            let users = documents.map({ User(user: $0.data())})
            self.users = users
            self.isLoading = false
        }
    }
    
    func searchUsers(_ query:String) {
        self.filteredUsers = users.filter ({ $0.fullName.lowercased().contains(query.lowercased()) || $0.userName.lowercased().contains(query.lowercased()) })
    }
    
    
    
    
}
