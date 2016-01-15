//
//  TFServerManager.swift
//  thriftify
//
//  Created by Vadim Trulyaev on 1/15/16.
//  Copyright © 2016 vt. All rights reserved.
//

import UIKit
import Alamofire

class TFServerManager {
    
    init() {
    }
    
    func getTransactions ()
    {
        Alamofire.request(TFServerManager.Router.TransactionListFull)
            .responseJSON () {
                response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }
    }
    
    enum Router: URLRequestConvertible {
        
        static let baseURLString = "https://api.parse.com/1"
        static let consumerKey = "XDh0czeU4HSzoWCC5R6Bhv8MRuHVQxL4Cvfv9FOQ"
        static let RESTAPIKey = "cgH2dajw4usnlR23UT4jOjXqWuhDSwONQQ6WysNg"
        
        case TransactionListFull
        case PopularPhotos(Int)
        case Comments(Int, Int)
        
        var URLRequest: NSMutableURLRequest {
            
            let (path, parameters) : (String, [String: AnyObject]?) = {
                
                switch self {
                case .TransactionListFull:
                    return ("/classes/Transactions",nil)
                    
                case .PopularPhotos(let page):
                    let params = ["consumer_key": Router.consumerKey, "page": "\(page)", "feature": "popular", "rpp": "50", "include_store": "store_download", "include_status": "votes"]
                    return ("/phtos", params)
                    
                case .Comments(let photoID, let commentsPage):
                    let params = ["consumer_key": Router.consumerKey, "comments": "1", "comments_page": "\(commentsPage)"]
                    return ("/photos/\(photoID)/comments", params)
                }
            }()
            
            let URL = NSURL(string: Router.baseURLString)
            let URLRequest = NSMutableURLRequest(URL: URL!.URLByAppendingPathComponent(path))
            URLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            URLRequest.setValue(Router.consumerKey, forHTTPHeaderField: "X-Parse-Application-Id")
            URLRequest.setValue(Router.RESTAPIKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
            
            let encoding = Alamofire.ParameterEncoding.URL
            
            return encoding.encode(URLRequest, parameters: parameters).0
        }
    }
}

func += <KeyType, ValueType> (inout left: Dictionary<KeyType, ValueType>, right: Dictionary<KeyType, ValueType>) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}
