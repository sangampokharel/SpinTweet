//
//  SignUpView.swift
//  SpinTweet
//
//  Created by sangam pokharel on 27/02/2024.
//

import SwiftUI

struct SignUpView: View {
    @State private var email:String = ""
    @State private var password:String = ""
    @State private var fullName:String = ""
    @State private var userName:String = ""
    @State private var openImagePicker = false
    @State private var selectedImage:UIImage?
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var authViewModel:AuthStateViewModel
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing:30) {
                    Spacer()
                    Button(action: {
                        //  OPEN GALLERY AND CODE
                        openImagePicker.toggle()
                    }, label: {
                        if let selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150,height: 150)
                                .clipShape(Circle())
                                
                        }else{
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150,height: 150)
                        }
                      
                    })
                    
                    
                    HStack{
                        TextField("Full Name", text: $fullName)
                            .padding(.horizontal,20)
                    }.padding()
                        .frame(width: UIScreen.main.bounds.width - 40,height: 50)
                        .background(RoundedRectangle(cornerRadius: 4).fill(Color.gray.opacity(0.4)))
                        .overlay(alignment: .leading) {
                            Image(systemName: "person")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(.horizontal,8)
                                .foregroundStyle(Color.gray.opacity(0.6))
                        }
                    
                    HStack{
                        TextField("Email", text: $email)
                            .padding(.horizontal,20)
                    }.padding()
                        .frame(width: UIScreen.main.bounds.width - 40,height: 50)
                        .background(RoundedRectangle(cornerRadius: 4).fill(Color.gray.opacity(0.4)))
                        .overlay(alignment: .leading) {
                            Image(systemName: "mail")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(.horizontal,8)
                                .foregroundStyle(Color.gray.opacity(0.6))
                        }
                    
                    HStack{
                        TextField("Username", text: $userName)
                            .padding(.horizontal,20)
                    }.padding()
                        .frame(width: UIScreen.main.bounds.width - 40,height: 50)
                        .background(RoundedRectangle(cornerRadius: 4).fill(Color.gray.opacity(0.4)))
                        .overlay(alignment: .leading) {
                            Image(systemName: "person")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(.horizontal,8)
                                .foregroundStyle(Color.gray.opacity(0.6))
                        }
                    
                    
                    HStack{
                        SecureField("Password", text: $password)
                            .padding(.horizontal,20)
                    }.padding()
                        .frame(width: UIScreen.main.bounds.width - 40,height: 50)
                        .background(RoundedRectangle(cornerRadius: 4).fill(Color.gray.opacity(0.4)))
                        .overlay(alignment: .leading) {
                            Image(systemName: "key")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(.horizontal,8)
                                .foregroundStyle(Color.gray.opacity(0.6))
                        }
                    
                    Button(action: {
                          authViewModel.registerUser(fullname: fullName, email: email, username: userName, password: password, image: selectedImage)
                    }, label: {
                        Text("Sign Up")
                            .foregroundStyle(Color.white)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width - 40)
                            .background(RoundedRectangle(cornerRadius: 4).fill(Color.blue))
                            .shadow(radius: 10)
                        
                    })
                    
                    Spacer()
                    
                    
                }
                .sheet(isPresented: $openImagePicker, content: {
                    ImagePickerHandler(selectedImage: $selectedImage, isShowingImagePicker: $openImagePicker)
                })
                .frame(maxWidth: UIScreen.main.bounds.width)
            }
            
            if authViewModel.isLoading {
                LoadingView()
            }
        }
       
    }
}

#Preview {
    SignUpView()
}
