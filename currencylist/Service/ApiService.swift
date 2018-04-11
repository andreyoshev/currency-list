//
//  ApiServiceBase.swift
//  currencylist
//
//  Created by Andrey Oshev on 11/04/2018.
//  Copyright © 2018 Andrey Oshev. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

#if DEVELOPMENT
private let ApiServiceHost = "phisix-api3.appspot.com"
#else
private let ApiServiceHost = "phisix-api3.appspot.com"
#endif

private let ApiServiceHostUrl = "http://" + ApiServiceHost
private let ApiServiceFileUrl = ApiServiceHostUrl + "/stocks.json"

class ApiService {
    
    typealias CompletionHandler = (_ result: Any?, _ error: Error?) -> Void
    
    fileprivate func execute(method: HTTPMethod = .get,
                             urlString: String,
                             params: Parameters? = nil,
                             encoding: ParameterEncoding = URLEncoding.default,
                             completionHandler: CompletionHandler? = nil) -> Request? {
        return Alamofire.SessionManager.default.request(urlString,
                                                        method: method,
                                                        parameters: params,
                                                        encoding: encoding,
                                                        headers: nil)
            .responseJSON {
                if ($0.result.error == nil) {
                    completionHandler?($0.result.value, nil)
                }
                else {
                    completionHandler?(nil, $0.result.error)
                }
        }
    }
    
    // MARK: - ApiService
    
    // MARK: -- Currency
    
    /// Execute mathod to get stocks
    ///
    /// - Parameter completionHandler: return a new created array of currency, error
    /// - Returns: return a new created alamofire request
    @discardableResult
    func getStocks(completionHandler: CompletionHandler? = nil) -> Request? {
        return execute(method: .get,
                       urlString: ApiServiceFileUrl,
                       completionHandler: { (result, error) in
                        if let result = result as? [String : AnyObject], let stocks = result["stock"] as? [[String : AnyObject]] {
                            let currencies = Mapper<Currency>().mapArray(JSONArray: stocks)
                            completionHandler?(currencies, nil)
                        }
                        else {
                            completionHandler?(nil, error)
                        }
            })
    }
}
