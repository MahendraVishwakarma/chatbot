//
//  ChatModel{.swift
//  ChatBot
//
//  Created by Mahendra Vishwakarma on 04/01/22.
//
/*
 {"success":1,"errorMessage":"","message":
 {"chatBotName":"CyberTy","chatBotID":63906,"message":"
 sup?","emotion":null}}
 */

import Foundation
struct ChatModel:Codable {
    let success:Int?
    let errorMessage:String?
    let message:Message?
    
}

struct Message:Codable {
    let chatBotName:String?
    let chatBotID:Int?
    let message: String?
    let emotion:String?
}
