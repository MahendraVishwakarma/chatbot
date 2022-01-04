//
//  ChatViewModel.swift
//  ChatBot
//
//  Created by Mahendra Vishwakarma on 04/01/22.
//

import Foundation

class ChatViewModel {
    var totalChatMessage:Array<Message>?
    weak var delegate: ServerDelegate?
    var toogleAttachment:Bool = false
    
    init() {
        totalChatMessage = Array<Message>()
        let msgTimeStamp = Date().timeIntervalSince1970
        let msg  = Message(chatBotName: "", chatBotID: 5, message: "Message from remote user", emotion: "", timestamp: msgTimeStamp)
        let msg1  = Message(chatBotName: "", chatBotID: 5, message: "Hi", emotion: "", timestamp: msgTimeStamp)
        let msg2  = Message(chatBotName: "", chatBotID: 5, message: "How are you?", emotion: "", timestamp: msgTimeStamp)
        totalChatMessage?.append(msg)
        totalChatMessage?.append(msg1)
        totalChatMessage?.append(msg2)
        
    }
    
    func sendMessage(messgae:String)  {
        let msgTimeStamp = Date().timeIntervalSince1970
        let msg  = Message(chatBotName: "", chatBotID: 6, message: messgae, emotion: "", timestamp: msgTimeStamp)
        totalChatMessage?.append(msg)
        self.delegate?.update(status: .success)
        
        
//        let requestURL = Utils.cityURL
//        Webservices.requesData(url: requestURL) { [weak self] (result:Result<ChatModel,APIError>) in
//            switch result {
//            case .success(let res):
//                if res.success == 0 {
//                    self?.delegate?.update(status: .success)
//                }else {
//                    self?.delegate?.update(status: .failed)
//                }
//
//            case .failure(_):
//                self?.delegate?.update(status: .failed)
//            }
//        }
    }
}

protocol ServerDelegate:AnyObject {
    func update(status:Status)
}

enum Status {
    case failed
    case success
}
