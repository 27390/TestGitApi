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
    
    //MARK: Search items
    private let baseSearchURL = "https://api.github.com/search/repositories?q="
    
    //MARK: Get readme items
    //https://raw.githubusercontent.com/facebook/react/master/README.md
    private let prefixGetReadmeURL = "https://raw.githubusercontent.com/"
    private let suffixGetReadmeURL = "/master/README.md"
    
    //MARK: Type definitions
    typealias searchSuccessBlock = (_ response: [[String: Any]]) -> Void
    typealias searchFailBlock = (_ responseErrorCode: String) -> Void
    typealias getReadmeSuccessBlock = (_ response: String) -> Void
    typealias getReadmeFailBlock = (_ responseErrorCode: String) -> Void
    
    private init () {
        
    }
    
    
    
    func requestRepositoryList(searchQuery: String, success: @escaping searchSuccessBlock, failure: searchFailBlock){
        let queryString = "\(baseSearchURL)\(searchQuery)"
        
        Alamofire.request(queryString).responseJSON { response in
//            print("Request: \(String(describing: response.request))")   // original url request
//            print("Response: \(String(describing: response.response))") // http url response
            //print("Result: \(response.result)")                         // response serialization result
            if let json = response.result.value as? [String: Any], let items = json["items"] as? [[String: Any]] {
                //print("\(String(describing: response.result.value))")
                success(items)
            }
        }
    }
    
    func requestReadmeForRepository(repoFullName: String, success: @escaping getReadmeSuccessBlock, failure: getReadmeFailBlock){
        let urlString = prefixGetReadmeURL + repoFullName + suffixGetReadmeURL
        
        Alamofire.request(urlString).responseJSON { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                //print("Data: \(utf8Text)") // original server data as UTF8 string
                success(utf8Text)
            }
        }
    }
    
}
