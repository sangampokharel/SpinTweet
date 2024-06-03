//
//  HomeTweetItem.swift
//  SpinTweet
//
//  Created by sangam pokharel on 21/02/2024.
//

import SwiftUI
import Kingfisher
import Firebase

struct HomeTweetItem: View {
    
    @ObservedObject var homeViewModel:HomeViewModel
    let tweet:TweetModel?
    
    var body: some View {
        VStack(spacing:4) {
            HStack(spacing: 20) {
                Spacer()
                KFImage(URL(string: tweet?.profileImageUrl ?? ""))
                    .resizable()
                    .frame(width: 50,height: 50)
                    .clipShape(Circle())
                
                VStack(alignment: .leading,spacing: 12){
                    HStack{
                        Text(tweet?.fullname ?? "")
                            .foregroundStyle(Color.primary)
                        Text("@\(tweet?.username ?? "")")
                            .foregroundStyle(.gray)
                        Text("\(tweet?.dateFormat ?? "-")")
                            .foregroundStyle(.gray)
                    }
                    
                    Text(tweet?.caption ?? "")
                        .foregroundStyle(Color.primary)
                        .frame(maxWidth: 350,alignment: .leading)
                    
                    HStack{
                        Button(action: {}, label: {
                            Label(
                                title: { Text("0") },
                                icon: { Image(systemName: "bubble.left") }
                            )
                        })
                        
                        Button(action: {}, label: {
                            Label(
                                title: { Text("0") },
                                icon: { Image(systemName: "arrow.up.arrow.down") }
                            )
                        }).padding(.horizontal,5)
                        
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
                        
                        Button(action: {}, label: {
                            Label(
                                title: { Text("0") },
                                icon: { Image(systemName: "square.and.arrow.up") }
                            )
                        })
                        .padding(.horizontal,5)
                    }.foregroundStyle(.gray)
                    
                }
            }
            Divider()
                .padding(.vertical)
        }
    }
}

//#Preview {
//    HomeTweetItem()
//}
