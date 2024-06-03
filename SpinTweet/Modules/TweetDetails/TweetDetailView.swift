//
//  TweetDetailView.swift
//  SpinTweet
//
//  Created by sangam pokharel on 27/05/2024.
//

import SwiftUI
import Kingfisher

struct TweetDetailView: View {
    
    var tweet: TweetModel?
    let homeViewModel = HomeViewModel.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing:10) {
            HStack(spacing:20) {
                KFImage(URL(string: tweet?.profileImageUrl ?? ""))
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)
                
                VStack(alignment: .leading) {
                    Text(tweet?.fullname ?? "")
                        .font(.title3)
                        .foregroundStyle(.primary)
                    Text("@\(tweet?.username ?? "")")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                }
                
                Spacer()
                
            }
            
            Text(tweet?.caption ?? "")
                .font(.footnote)
                .foregroundStyle(.primary)
            
            Text(tweet?.dateFormat ?? "")
                .font(.footnote)
                .foregroundStyle(.gray)
            Divider()
            
            HStack(spacing:20) {
                HStack {
                    Text("0")
                        .font(.footnote)
                        .foregroundStyle(.primary)
                    Text("Retweets")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                }
                
                HStack{
                    Text("\(tweet?.likes ?? 0)")
                        .font(.footnote)
                        .foregroundStyle(.primary)
                    Text("Likes")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                }
            }
            
            Divider()
            
            HStack{
                Button(action: {}, label: {
                    Label(
                        title: { Text("0") },
                        icon: { Image(systemName: "bubble.left") }
                    )
                })
                
                Spacer()
                
                Button(action: {}, label: {
                    Label(
                        title: { Text("0") },
                        icon: { Image(systemName: "arrow.up.arrow.down") }
                    )
                }).padding(.horizontal,5)
                
                Spacer()
                
                Button(action: {
                    guard let tweet else {return}
                    tweet.hasLiked ? homeViewModel.unLikeTweet(tweet: tweet) : homeViewModel.likeTweets(tweet: tweet)
                }, label: {
                    Label(
                        title: { Text("\(tweet?.likes ?? 0)") },
                        icon: {  Image(systemName: tweet?.hasLiked ?? false ? "heart.fill": "heart").foregroundStyle(
                            tweet?.hasLiked ?? false ? .red :  .gray
                        ) }
                    )
                })
                
                Spacer()
                
                Button(action: {}, label: {
                    Label(
                        title: { Text("0") },
                        icon: { Image(systemName: "square.and.arrow.up") }
                    )
                })
                .padding(.horizontal,5)
            }.foregroundStyle(.gray)
            
            Divider()
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    TweetDetailView()
}
