//
//  LoadingView.swift
//  SpinTweet
//
//  Created by sangam pokharel on 29/05/2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground).opacity(0.5)
                .ignoresSafeArea()
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.primary))
                .scaleEffect(2)
        }
    }
}

#Preview {
    LoadingView()
}
