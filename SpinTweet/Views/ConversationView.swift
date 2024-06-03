//
//  ConversationView.swift
//  SpinTweet
//
//  Created by sangam pokharel on 23/02/2024.
//

import SwiftUI
import Kingfisher

struct ConversationView: View {
    let message: Message
    var body: some View {
        VStack(spacing:4) {
            HStack(alignment: .top) {
                KFImage(URL(string: message.user.profileUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack{
                        Text(message.user.fullName)
                            .foregroundStyle(Color(UIColor.label))
                        Text("@\(message.user.userName)")
                            .foregroundStyle(Color.gray)
                          
                    } .font(.footnote)
                    Text(message.text)
                        .foregroundStyle(Color.gray)
                        .font(.footnote)
                }
                Spacer()
                Text("\(message.dateFormat)")
                    .foregroundStyle(Color.gray)
                    .font(.footnote)
            }
            
            Divider()
                .padding(.top,8)
        }
    }
}
//
//#Preview {
//    ConversationView()
//}
