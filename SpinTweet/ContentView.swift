//
//  ContentView.swift
//  SpinTweet
//
//  Created by sangam pokharel on 18/02/2024.
//

import SwiftUI
import Kingfisher
struct ContentView: View {
    @EnvironmentObject var authStateViewModel: AuthStateViewModel
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedIndex = 0
    @State private var search = ""
    @State private var isTweetShown = false
    @State private var navigateToProfile = false
    let searchViewModel = SearchViewModel.shared
    
    init(){
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().tintColor = .label
    }
    
    var body: some View {
        Group {
            if authStateViewModel.userSession {
                TabView(selection:$selectedIndex) {
                    NavigationView {
                        ZStack(alignment: .bottomTrailing) {
                            HomeView()
                                .navigationBarTitleDisplayMode(.inline)
                                .toolbar {
                                    ToolbarItem(placement: .topBarLeading) {
                                        Button(action: {
                                            navigateToProfile = true
                                        }, label: {
                                            
                                            KFImage(URL(string: authStateViewModel.user?.profileUrl ?? ""))
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .clipShape(Circle())
                                        })
                                        
                                    }
                                    
                                    ToolbarItem(placement: .principal) {
                                        Image(colorScheme == .dark ? "X1" : "X")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30, height: 30)
                                            .clipShape(Circle())
                                    }
                                    
                                    
                                    ToolbarItem(placement: .topBarTrailing) {
                                        Button {
                                            authStateViewModel.handleLogout()
                                        } label: {
                                            Image(systemName: "gear")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 20, height: 20)
                                            
                                        }.foregroundStyle(Color.gray)
                                        
                                        
                                    }
                                }
                            
                            Button {
                                isTweetShown.toggle()
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .padding()
                                    .background {
                                        Color.blue
                                    }
                                    .foregroundStyle(Color.white)
                                    .clipShape(Circle())
                            }
                            .padding()
                        }.fullScreenCover(isPresented: $isTweetShown, content: {
                            Tweet(isTweetShown:$isTweetShown)
                        })
                    } .tabItem {
                        Image(systemName: "house")
                            .resizable()
                            .scaledToFit()
                    }
                    .tag(0)
                    
                    NavigationView {
                        ZStack {
                            //                            NavigationLink(destination: ProfileView(),isActive: $navigateToProfile) {
                            //                                EmptyView()
                            //                            }
                            SearchView()
                                .navigationBarTitleDisplayMode(.inline)
                                .toolbar {
                                    ToolbarItem(placement: .topBarLeading) {
                                        Button(action: {
                                            navigateToProfile = true
                                        }, label: {
                                            KFImage(URL(string: authStateViewModel.user?.profileUrl ?? ""))
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .clipShape(Circle())
                                        })
                                        
                                    }
                                    
//                                    ToolbarItem(placement: .principal) {
//                                        Group {
//                                            
//                                            TextField(text: $search) {
//                                                if search.isEmpty {
//                                                    Text("  search...")
//                                                }else{
////                                                    searchViewModel.searchUsers(search)
//                                                }}
//                                            .padding(.horizontal)
//                                            
//                                            
//                                        }  .frame(width: UIScreen.main.bounds.width - 120,height: 40)
//                                            .background(RoundedRectangle(cornerRadius: 20).fill(Color.gray.opacity(0.2)))
//                                        
//                                    }
                                    
                                    ToolbarItem(placement: .principal) {
                                        Text("Users")
                                    }
                                    ToolbarItem(placement: .topBarTrailing) {
                                        Button {
                                            authStateViewModel.handleLogout()
                                        } label: {
                                            Image(systemName: "gear")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 20, height: 20)
                                            
                                        }.foregroundStyle(Color.gray)
                                        
                                        
                                    }
                                }
                        }
                    }
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFit()
                        
                    }
                    .tag(1)
                    
                    NavigationView{
                        ZStack(alignment: .bottomTrailing) {
                            //                            NavigationLink(destination: ProfileView(),isActive: $navigateToProfile) {
                            //                                EmptyView()
                            //                            }
                            MessagingView()
                                .navigationBarTitleDisplayMode(.inline)
                                .toolbar {
                                    ToolbarItem(placement: .topBarLeading) {
                                        Button(action: {
                                            navigateToProfile = true
                                        }, label: {
                                            KFImage(URL(string: authStateViewModel.user?.profileUrl ?? ""))
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .clipShape(Circle())
                                        })
                                        
                                    }
                                    
                                    ToolbarItem(placement: .principal) {
                                        Text("Messages")
                                    }
                                    
                                    
                                    ToolbarItem(placement: .topBarTrailing) {
                                        Button {
                                            authStateViewModel.handleLogout()
                                        } label: {
                                            Image(systemName: "gear")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 20, height: 20)
                                            
                                        }.foregroundStyle(Color.gray)
                                        
                                        
                                    }
                                }
                            
//                            Button {
//                                
//                            } label: {
//                                Image(systemName: "plus.message.fill")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 30, height: 30)
//                                    .padding()
//                                    .background {
//                                        Color.blue
//                                    }
//                                    .foregroundStyle(Color.white)
//                                    .clipShape(Circle())
//                            }
//                            .padding()
                            
                        }
                        
                    }
                    
                    .tabItem {
                        Image(systemName: "message")
                            .resizable()
                            .scaledToFit()
                    }
                    .tag(2)
                }
                .transition(.move(edge: .trailing))
                
                
            }else{
                LoginView()
            }
        }
    }
    
    
}

#Preview {
    ContentView()
}
