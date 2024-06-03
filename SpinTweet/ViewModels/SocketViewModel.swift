//
//  SocketViewModel.swift
//  SpinTweet
//
//  Created by sangam pokharel on 06/03/2024.
//

import Foundation
import SwiftStomp

class SocketViewModel:ObservableObject, SwiftStompDelegate {
    
    private var swiftStomp:SwiftStomp!
    private var messageIndex = 0
    init(){
        let url = URL(string: "wss://devws.nepalpay.com.np/nqrws")!
        
        self.swiftStomp = SwiftStomp(host: url) //< Create instance
        self.swiftStomp.enableLogging = true
        self.swiftStomp.delegate = self //< Set delegate
        self.swiftStomp.autoReconnect = true //< Auto reconnect on error or cancel
        self.swiftStomp.enableAutoPing()
        if !self.swiftStomp.isConnected{
            self.swiftStomp.connect(timeout: 5.0, acceptVersion: "1.1,1.2") //< Connect
        }
    }
    
    func onConnect(swiftStomp: SwiftStomp, connectType: StompConnectType) {
        if connectType == .toSocketEndpoint{
            print("Connected to socket")
        }else if connectType == .toStomp{
            print("Connected to stomp")
            //** Subscribe to topics or queues just after connect to the stomp!
            swiftStomp.subscribe(to: "/user/nqrws/check-txn-status")
        }
    }
    
    func onDisconnect(swiftStomp: SwiftStomp, disconnectType: StompDisconnectType) {
        if disconnectType == .fromSocket{
            print("Socket disconnected. Disconnect completed")
        } else if disconnectType == .fromStomp{
            print("Client disconnected from stomp but socket is still connected!")
        }
    }
    
    func onMessageReceived(swiftStomp: SwiftStomp, message: Any?, messageId: String, destination: String, headers: [String : String]) {
        print("Received something \(messageId) \(destination) \(headers)")
        if let message = message as? String{
            print("Message with id `\(messageId)` received at destination `\(destination)`:\n\(message)")
        } else if let message = message as? Data{
            print("Data message with id `\(messageId)` and binary length `\(message.count)` received at destination `\(destination)`")
        }
    }
    
    func onReceipt(swiftStomp: SwiftStomp, receiptId: String) {
        print("Receipt with id `\(receiptId)` received")
    }
    
    func onError(swiftStomp: SwiftStomp, briefDescription: String, fullDescription: String?, receiptId: String?, type: StompErrorType) {
        if type == .fromSocket{
            print("Socket error occurred! [\(briefDescription)]")
        } else if type == .fromStomp{
            print("Stomp error occurred! [\(briefDescription)] : \(String(describing: fullDescription))")
        } else {
            print("Unknown error occured!")
        }
    }
    
    func onSocketEvent(eventName: String, description: String) {
        print("Socket event occured: \(eventName) => \(description)")
    }
    
    struct MainData:Codable {
        var merchant_id:String = "Terminal1"
        var request_id:String = "2403060000226850QNE"
        var username:String = "merokinmelnqr"
        var api_token:String = "DXWSm5m+qEUPpdy8XYc7sjm3fhr4hRm6blvVBZmaxJ9V8+OTr1YkKV6W+IP5Q2NtSRE1p0j7FhRlIbGoEpLfIzdmb/Sp7CCUm7Bo/ziVVAUX7a1MzErkqlSuUJrKOQhtDyT2czVitOBytbbu/bkoYHsdph+TEcHZ3y5aoHopONMONTMi3cckvcjC9OmmpcQcVu79kA8Gq7vJNKyMd+0vdYEifnpZ1fKswTBHVzIAMAtT69JRf3mreqOiJCXSDGcQTB6NginD2IkdzcPZfz9l0Y8W4mSVUEH308g8TiTMdaV/x3uz8zdNxhvaUCec5vOjlb6C6Z5xgsZN/9Cv2BCrOA=="
    }
    
    func sendMessage() {
        swiftStomp.send(body: MainData(), to: "/nqrws/check-txn-status")
    }
    
    
}
