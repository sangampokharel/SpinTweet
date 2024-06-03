//
//  SpinTweetApp.swift
//  SpinTweet
//
//  Created by sangam pokharel on 18/02/2024.
//

import SwiftUI
import Firebase

@main
struct SpinTweetApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AuthStateViewModel.shared)
        }
    }
}
