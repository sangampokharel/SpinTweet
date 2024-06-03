//
//  ChatBubble.swift
//  SpinTweet
//
//  Created by sangam pokharel on 23/02/2024.
//

import Foundation
import SwiftUI

struct ChatBubble:Shape {
    var isCurrentUser:Bool
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight, isCurrentUser ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: 16, height: 16))
        return Path(path.cgPath)
    }
}

