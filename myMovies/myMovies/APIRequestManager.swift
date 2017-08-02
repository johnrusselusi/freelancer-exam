//
//  APIRequestManager.swift
//  myMovies
//
//  Created by John Russel Usi on 31/07/2017.
//  Copyright © 2017 johnrusselusi. All rights reserved.
//

import Foundation

typealias SuccessBlock = ([String: Any]) -> Void
typealias ErrorBlock = (Error) -> Void

class APIRequestManager: NSObject {
    
    static let sharedInstance = APIRequestManager()
    
    func httpGETRequest(urlString: String, parameters: [String: Any]?, successBlock: @escaping SuccessBlock, errorBlock: @escaping ErrorBlock) -> Void {
        
        var string = urlString
        parameters?.forEach({ (key, value) in
            string.append("\(key)=\(value)&")
        })
        
        let url = URL(string: string)
        let session = URLSession.shared
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
            
                errorBlock(error!)
            }
            else {
            
                do {
                    
                    let jsonResponse: [String: Any] = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                    successBlock(jsonResponse)
                }
                catch {
                    
                    errorBlock(error)
                }
            }
        }
        
        task.resume()
    }
}
