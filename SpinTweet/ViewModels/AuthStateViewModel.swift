//
//  AuthStateViewModel.swift
//  SpinTweet
//
//  Created by sangam pokharel on 29/02/2024.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage
class AuthStateViewModel:BaseViewModel {
    
    //MARK: Properties
    @Published var userSession = false
    @Published var user:User?
    
    static let shared = AuthStateViewModel()
    
    override init(){
        super.init()
        userSession = (Auth.auth().currentUser != nil) ? true : false
        getProfile()
    }
    
    //MARK: Login
    func handleLogin(email:String,password:String) {
        if email.isEmpty {
            showValidationError(error: "Email is required")
        }else if password.isEmpty {
            showValidationError(error: "Password is required")
        }else{
            isLoading = true
            Auth.auth().signIn(withEmail: email, password: password){ [weak self] result,error  in
                guard let self else {return}
                if let error {
                    isLoading = false
                    self.showValidationError(error: error.localizedDescription)
                    return
                }
                print("DEBUG: User LOGGED IN successfully!")
                userSession = true
                self.getProfile()
            }
            
        }
    }
    
    //MARK: Register
    func registerUser(fullname:String,email:String,username:String,password:String,image:UIImage?) {
        if fullname.isEmpty {
            showValidationError(error: "Full Name is required")
        }else if email.isEmpty {
            showValidationError(error: "Email is required")
        }else if password.isEmpty {
            showValidationError(error: "Password is required")
        }else if username.isEmpty {
            showValidationError(error: "Username is required")
        }else{
            guard let image else {
                showValidationError(error: "Image is required")
                return
            }
            isLoading = true
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
                if let error {
                    self?.isLoading = false
                    self?.showValidationError(error: error.localizedDescription)
                    return
                }
                print("DEBUG: USER CREATED SUCCESSFULLY")
                guard let uid = result?.user.uid else { return }
                self?.uploadProfileImage(uid: uid,email: email,fullName:fullname,userName:username,selectedImage:image)
            }
        }
    }
    
    //MARK: Upload Profile Image
    func uploadProfileImage(uid: String,email:String,fullName:String,userName:String,selectedImage:UIImage) {
        guard let imageData = selectedImage.jpegData(compressionQuality: 0.2) else { return }
        let storageRef = Storage.storage().reference().child("profile_images").child("\(uid).jpg")
        
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                self.showValidationError(error: error.localizedDescription)
                return
            }
            
            print("DEBUG: IMAGE UPLOADED SUCCESSFULLY")
            
            storageRef.downloadURL { url, error in
                if let error = error {
                    self.showValidationError(error: error.localizedDescription)
                    return
                }
                
                guard let downloadURL = url?.absoluteString else { return }
                
                print("DEBUG: IMAGE DOWNLOADED SUCCESSFULLY")
                
                // Proceed to save user data to Firestore
                self.saveUserToFirestore(uid: uid, email: email, imageUrl: downloadURL,fullName:fullName,userName:userName)
            }
        }
    }
    
    //MARK: Save User
    func saveUserToFirestore(uid: String,email:String, imageUrl: String,fullName:String,userName:String) {
        let db = Firestore.firestore()
        let userData: [String: Any] = [
            "uid": uid,
            "email": email,
            "profileImageUrl": imageUrl,
            "fullName":fullName,
            "userName":userName
        ]
        
        db.collection("users").document(uid).setData(userData) { [weak self] error in
            guard let self else {return}
            if let error = error {
                self.isLoading = false
                self.showValidationError(error: error.localizedDescription)
                return
            }
            print("DEBUG: User data saved successfully!")
            // User data saved successfully
            self.userSession = true
            self.getProfile()
            
        }
    }
    
    //MARK: Get Profile
    func getProfile(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            if let error {
                self.isLoading = false
                self.showValidationError(error: error.localizedDescription)
                return
            }
            
            print("DEBUG: PROFILE FETCH SUCCESSFULLY")
            self.isLoading = false
            let data = snapshot?.data()
            let user = User(user: data ?? [:])
            self.user = user
            
            print("DEBUG: User \(user.fullName)")
            
        }
    }
    
    //MARK: Logout
    func handleLogout() {
        isLoading = true
        try? Auth.auth().signOut()
        self.isLoading = false
        userSession = false
        user = nil
        
    }
    
    
}
