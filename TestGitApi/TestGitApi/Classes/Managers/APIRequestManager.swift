//
//  APIRequestManager.swift
//  TestGitApi
//
//  Created by Alex on 30/07/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import Alamofire

class APIRequestManager {
    static let sharedInstance = APIRequestManager ()
    
    //https://api.github.com/search/repositories?q=tetris+language:assembly&sort=stars&order=desc
    private let baseURL = "https://api.github.com/search/repositories?q="
    private var requestQuerry: DataRequest?
    
    private init () {
        
    }
    
    typealias successBlock = (_ response: [[String: Any]]) -> Void
    typealias failBlock = (_ responseErrorCode: String) -> Void
    
    func requestRepositoryList(searchQuery: String, success: @escaping successBlock, failure: failBlock){
        let queryString = "\(baseURL)\(searchQuery)"
        
        Alamofire.request(queryString).responseJSON { response in
//            print("Request: \(String(describing: response.request))")   // original url request
//            print("Response: \(String(describing: response.response))") // http url response
            //print("Result: \(response.result)")                         // response serialization result
            if let json = response.result.value as? [String: Any], let items = json["items"] as? [[String: Any]] {
                success(items)
            }
        }
    }
}
