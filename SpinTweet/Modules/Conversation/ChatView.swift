//
//  ConversationView.swift
//  SpinTweet
//
//  Created by sangam pokharel on 23/02/2024.
//

import SwiftUI
import Kingfisher


struct ChatView: View {
    @State private var messageTxt:String = ""
    @State private var isCurrentUser = false
    @ObservedObject private var chatViewModel:ChatViewModel
    let user:User?
    
    init(user:User) {
        self.user = user
        chatViewModel = ChatViewModel(user: user)
    }
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .leading){
                    ForEach(chatViewModel.messages) { item in
                        ChatItem(message:item)
                    }
                }
                .padding(.horizontal)
             }
            
            
            HStack {
                TextField(" Message me...", text: $messageTxt)
                    .padding(.horizontal)
                    
                Button(action: {
                   chatViewModel.sendMessage(messageText: messageTxt)
                    messageTxt = ""
                }, label: {
                    Image(systemName: "paperplane.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30,height: 30)
                        .padding(.horizontal,5)
                        
                })
            }
            .frame(width: UIScreen.main.bounds.width - 50,height: 40)
            .background(
                RoundedRectangle(cornerRadius: 50).fill(Color.gray.opacity(0.3))
            )
            .padding(.bottom)
        }
        .navigationTitle(user?.userName ?? "")
        .onTapGesture {
            
        }
    }
}

struct ChatItem:View {
    var message:Message
    var body: some View {
        if message.isFromCurrentUser {
            HStack {
                Spacer()
                Text(message.text)
                    .padding(.vertical,16)
                    .padding(.horizontal,16)
                    .background(
                        Color.blue)
                    .clipShape(ChatBubble(isCurrentUser: message.isFromCurrentUser))
            }
        }else{
            HStack {
                KFImage(URL(string: message.user.profileUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                Text(message.text)
                    .padding(.vertical,16)
                    .padding(.horizontal,16)
                    .background(
                        Color.gray.opacity(0.4)
                    )
                    .clipShape(ChatBubble(isCurrentUser: message.isFromCurrentUser))
                Spacer()
            }
        }
     
    }
}

//#Preview {
//    ConversationView()
//}
