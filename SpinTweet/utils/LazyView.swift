//
//  LazyView.swift
//  SpinTweet
//
//  Created by sangam pokharel on 29/05/2024.
//

import SwiftUI

struct LazyView<Content: View>: View {
    var content: () -> Content

    var body: some View {
        content()
    }

    init(_ content: @escaping @autoclosure () -> Content) {
        self.content = content
    }
}
