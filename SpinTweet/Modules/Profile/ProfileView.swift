//
//  ProfileView.swift
//  SpinTweet
//
//  Created by sangam pokharel on 25/02/2024.
//

import SwiftUI
import Kingfisher
enum Categories:String,CaseIterable {
    case Tweets = "Tweets"
    case TweetsReplies = "Tweets & Replies"
    case Likes = "Likes"
}

struct ProfileView: View {
    var user:User?
    @State private var selectedTab = Categories.allCases[0].rawValue
    @ObservedObject private var profileViewModel:ProfileViewModel
    
    init(user:User){
        self.user = user
        profileViewModel = ProfileViewModel(user: user)
        
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .center,spacing: 20) {
                    KFImage(URL(string: user?.profileUrl ?? ""))
                        .resizable()
                        .frame(width: 150,height: 150)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                        
                    VStack {
                        Text(user?.fullName ?? "")
                            .fontWeight(.bold)
                        Text("@\(user?.userName ?? "")")
                            .foregroundStyle(.gray)
                        Text("He is the most handsome boy in the world !")
                            .foregroundStyle(.gray)
                    }
                    
                    HStack(spacing:40){
                        VStack{
                            Text("\(profileViewModel.user.userStats.followers)")
                            Text("Followers")
                                .fontWeight(.bold)
                        }
                        
                        VStack{
                            Text("\(profileViewModel.user.userStats.following)")
                            Text("Following")
                                .fontWeight(.bold)
                        }
                    }
                    
                    if let user {
                        if user.isCurrentUser {
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Text("Edit Profile")
                                    .foregroundStyle(Color.white)
                                    .padding()
                                    .frame(width: 100)
                                    .background(Color.blue)
                                    .clipShape(Capsule())
                                
                            })
                        }else{
                            HStack(spacing:30) {
                                Button(action: {
                                    if profileViewModel.isFollowing {
                                        profileViewModel.unFollowUser()
                                    }else{
                                        profileViewModel.followUser()
                                    }
                                    
                                }, label: {
                                    Text(profileViewModel.isFollowing ? "Following": "Follow")
                                        .foregroundStyle(Color.white)
                                        .padding()
                                        .frame(width: 100)
                                        .background(Color.blue)
                                        .clipShape(Capsule())
                                    
                                })
                                NavigationLink {
                                    LazyView(ChatView(user:profileViewModel.user))
                                } label: {
                                    Text("Message")
                                        .foregroundStyle(Color.white)
                                        .padding()
                                        .frame(width: 100)
                                        .background(Color.purple)
                                        .clipShape(Capsule())
                                }
                            }
                        }
                        
                    }
                }
                .font(.footnote)
                .padding()
                
                Spacer()
                
//                HStack {
//                    ForEach(Categories.allCases, id:\.self){item in
//                        VStack {
//                            Text(item.rawValue)
//                                .fontWeight(.bold)
//                            Rectangle()
//                                .frame(width: (UIScreen.main.bounds.width - 100) / 3 ,height: 2)
//                                .opacity(  item.rawValue == selectedTab ? 1 : 0)
//                                .animation(.spring, value: selectedTab)
//                        }.onTapGesture {
//                            selectedTab = item.rawValue
//                        }
//                        Spacer()
//                    }
//                }
//                .foregroundStyle(Color.blue)
                
    //            LazyVStack {
    //                ForEach(1 ... 10, id:\.self){item in
    //                    HomeTweetItem()
    //                }
    //            }
            }
            if profileViewModel.isLoading {
                LoadingView()
            }
        }
       
    }
}

