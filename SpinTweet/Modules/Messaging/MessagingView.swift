//
//  MessagingView.swift
//  SpinTweet
//
//  Created by sangam pokharel on 18/02/2024.
//

import SwiftUI

struct MessagingView: View {
    
    @StateObject private var conversationViewModel = ConversationViewModel()
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack {
                    ForEach(conversationViewModel.recentMessages){ item in
                        NavigationLink {
                           ChatView(user: item.user)
                        } label: {
                            ConversationView(message:item)
                                .padding(.horizontal)
                        }
     
                    }
                }.padding()
            }
            
            if conversationViewModel.isLoading {
                LoadingView()
            }
            
        }
        .onAppear {
            conversationViewModel.fetchRecentMessages()
        }
        .onDisappear {
            conversationViewModel.stopListening()
        }
    }
}

#Preview {
    MessagingView()
}
