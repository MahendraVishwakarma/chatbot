//
//  WebServices.swift
//  NyKaaTask
//
//  Created by Mahendra Vishwakarma on 21/12/21.
//

import Foundation
import UIKit


class Webservices {
    
    class func requesData<T:Decodable>(url:String?, complitionHandler:@escaping(_ result:Result<T,APIError>) -> Void) {
    guard let url = URL(string: url ?? "") else {
        return
    }
    let request = URLRequest(url: url)
    
    let session = URLSession.shared
    
    session.dataTask(with: request) { (data, response, error) in
        if error == nil {
            let decoder = JSONDecoder()
            if let validData = data {
                do {
                    
                    let object = try decoder.decode(T.self, from: validData)
                   
                    complitionHandler(.success(object))
                }catch let error {
                   
                    complitionHandler(.failure(.failedRequest(error.localizedDescription)))
                }
               
            }
           
        }
    }.resume()
       
       // completionHandler(result: flag)
    }
}
