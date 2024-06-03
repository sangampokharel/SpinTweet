//
//  Tweet.swift
//  SpinTweet
//
//  Created by sangam pokharel on 23/02/2024.
//

import SwiftUI
import Kingfisher

struct Tweet: View {
    
    @State private var tweet:String = ""
    @Binding var isTweetShown:Bool
    @StateObject private var tweetViewModel = TweetViewModel()
  
    var body: some View {
        ZStack {
            NavigationView{
                VStack{
                    HStack(spacing:10) {
                        KFImage(URL(string: AuthStateViewModel.shared.user?.profileUrl ?? ""))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50,height: 50)
                            .clipShape(Circle())
                        
                        TextField("What's happening ?", text: $tweet)
                    }.padding()
                    
                    Spacer()
                }.navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                isTweetShown.toggle()
                            }
                                   , label: {
                                Text("Cancel")
                            })
                        }
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {
                                tweetViewModel.tweetText = tweet
                                tweetViewModel.uploadTweet {
                                    isTweetShown.toggle()
                                }
                            
                            }
                                   , label: {
                                Text("Tweet")
                            }).buttonStyle(.bordered)
                        }
                    }
            }
            
            if tweetViewModel.isLoading {
                LoadingView()
            }
        }

        
    }
}

//#Preview {
//    Tweet(isTweetShown: .constant(false))
//}
