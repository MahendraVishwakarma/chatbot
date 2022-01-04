//
//  Utils.swift
//  XMMPAuth
//
//  Created by Mahendra Vishwakarma on 24/10/21.
//

import Foundation
class Utils {
    static let cityURL = "http://www.personalityforge.com/api/chat/?apiKey=6nt5d1nJHkqbkphe&message=Hi&chatBotID=48646&externalID=mahendra&firstName=&lastName=&gender="
  
}

//Result type
public enum Result<T, U> where U:Error {
    case success(T)
    case failure(U)
}

// custom error
public enum APIError:Error {
     case failedRequest(String?)
}
// hTTPS methods type
public enum HttpsMethod {
    case Post
    case Get
    case Put
    case Delate
    
    var localization:String{
        switch self {
        case .Post: return "POST"
        case .Get: return "GET"
        case .Put: return "PUT"
        case .Delate: return "Delete"
            
        }
        
    }
}
