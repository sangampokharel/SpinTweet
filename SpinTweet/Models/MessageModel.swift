//
//  MessageModel.swift
//  SpinTweet
//
//  Created by sangam pokharel on 26/02/2024.
//

import Foundation



struct MessageModel:Hashable,Identifiable {
    let id:String
    let message:String
    let userImage:String
    let date:String
    let isCurrentUser:Bool
}

struct MessageGenerator {
    static let messages = [

        MessageModel(id: "1", message: "Hey, how are you doing ?", userImage: "", date: "21/12/2023", isCurrentUser: true),
        MessageModel(id: "2", message: "Yeah, I am good..", userImage: "", date: "21/12/2023", isCurrentUser: false),
        MessageModel(id: "3", message: "Did you comeplete your tasks?", userImage: "", date: "21/12/2023", isCurrentUser: true),
        MessageModel(id: "4", message: "when am i getting build  ?", userImage: "", date: "21/12/2023", isCurrentUser: true),

    ]

}
