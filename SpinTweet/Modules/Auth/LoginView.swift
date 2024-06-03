//
//  LoginView.swift
//  SpinTweet
//
//  Created by sangam pokharel on 26/02/2024.
//

import SwiftUI
import Combine

struct LoginView: View {
    @State private var email:String = ""
    @State private var password:String = ""
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var authStateViewModel:AuthStateViewModel
    
    func performLogin() {
        authStateViewModel.handleLogin(email: email,password: password)
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    VStack(spacing:30) {
                        Spacer()
                        Image(colorScheme == .dark ? "X1" : "X")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150,height: 150)
                            .background(Color.clear)
                        
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
                            performLogin()
                        }, label: {
                            Text("Login")
                                .foregroundStyle(Color.white)
                                .padding()
                                .frame(width: UIScreen.main.bounds.width - 40)
                                .background(RoundedRectangle(cornerRadius: 4).fill(Color.blue))
                                .shadow(radius: 8)
                            
                        })
                        
                        Spacer()
                        
                        NavigationLink {
                            SignUpView()
                        } label: {
                            Text("Don't have Account ?")
                                .font(.footnote)
                                .foregroundStyle(Color.gray)
                        }
                        
                    }
                    
                }
                .alert(authStateViewModel.showValidationError, isPresented: $authStateViewModel.hasError, actions: {
                    Button("oK") {
                        authStateViewModel.clearValidatoinError()
                    }
                })
                .onAppear(perform: {
                    print("Checking socket status")
                })
                .frame(maxWidth: UIScreen.main.bounds.width)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
            }
            if authStateViewModel.isLoading {
                LoadingView()
            }
        }
        
        
        
    }
}

#Preview {
    LoginView()
}
