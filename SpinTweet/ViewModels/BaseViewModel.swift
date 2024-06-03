//
//  BaseViewModel.swift
//  SpinTweet
//
//  Created by sangam pokharel on 29/02/2024.
//

import Foundation

class BaseViewModel:ObservableObject {
    
    @Published var isLoading = false
    @Published var showValidationError = ""
    @Published var hasError = false
    
    
    func showLoading(){
        isLoading = true
    }
    
    func hideLoading(){
        isLoading = false
    }
    
    func showValidationError(error:String){
        hasError = true
        showValidationError = error
    }
    
    func clearValidatoinError(){
        hasError = false
        showValidationError = ""
    }
    
}
