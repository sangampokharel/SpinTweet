//
//  HomeView.swift
//  SpinTweet
//
//  Created by sangam pokharel on 18/02/2024.
//

import SwiftUI



struct HomeView: View {
    
    @StateObject private var homeViewModel = HomeViewModel()
    
    var body: some View {
        ZStack{
            ScrollView {
                LazyVStack {
                    ForEach(homeViewModel.tweets){item in
                        NavigationLink {
                            TweetDetailView(tweet: item)
                        } label: {
//                        homeViewModel: homeViewModel,
                            HomeTweetItem( homeViewModel: homeViewModel, tweet:item)
                        }

                      
                    }
                }
                    
            }.refreshable {
                homeViewModel.fetchTweets()
            }
            
            if homeViewModel.isLoading {
                LoadingView()
            }
          
        }.padding(.vertical)
    }
}

#Preview {
    HomeView()
}
