//
//  SearchCell.swift
//  SpinTweet
//
//  Created by sangam pokharel on 24/05/2024.
//

import SwiftUI
import Kingfisher
struct SearchCell: View {
    var user:User?
    
    var body: some View {
        HStack(spacing:8) {
            KFImage(URL(string: user?.profileUrl ?? ""))
                .resizable()
                .frame(width: 50,height: 50)
                .cornerRadius(25)
            
            VStack(alignment: .leading, spacing:4) {
                Text("@\(user?.userName ?? "-")")
                Text(user?.fullName ?? "-")
                    .font(.footnote)
            }.foregroundStyle(Color.primary)
            Spacer()
        }
    }
}

