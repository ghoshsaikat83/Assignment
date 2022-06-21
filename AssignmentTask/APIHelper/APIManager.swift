//
//  APIManager.swift
//  AssignmentTask
//
//  Created by SAIKAT GHOSH on 21/06/22.
//

import UIKit

class APIManager: NSObject {
    
    static let sharedInstance: APIManager = APIManager()
    
    public func requestApiWithUrlString(apiAddress: String, param: String,requestType: String,
                                        completionHendler:@escaping (_ response:[DataModel],
                                                                     _ error: NSError?, _ success: Bool)-> Void ) {
        var apiUrl = apiAddress
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var request: URLRequest?
        
        let emptyDataModel = DataModel(id: 0, author: "", width: 0, height: 0, url: "", download_url: "")
        let emptyDataModelArray = [emptyDataModel]
        var resultDataModelArray = [DataModel]()
        
        if requestType == "GET" {
            
            apiUrl = apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            print("URL=",apiUrl)
            
            let url = URL(string: apiUrl)!
            request = URLRequest.init(url: url)
            request?.httpMethod = "GET"
            
        } else {
            apiUrl = apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            print("URL=",apiUrl)
            
            let bodyParameterData = param.data(using: .utf8)
            let url = URL(string: apiUrl)!
            
            request = URLRequest(url: url)
            request?.httpBody = bodyParameterData
            request?.httpMethod = "POST"
        }
        
        request?.timeoutInterval = 60.0
        request?.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        request?.httpShouldHandleCookies = true
        
        let dataTask = session.dataTask(with: request!) { (data, response, error) in
            
            if error != nil {
                completionHendler(emptyDataModelArray, error as NSError?, false)
            }; do {
                if data != nil  {
                    
                    //let resultJson = try JSONDecoder().decode([DataModel].self, from: data!)
                    
                    let resultJson = try JSONSerialization.jsonObject(with: data!, options: []) as! [NSDictionary]
                    for arr in resultJson{
                        
                        var dataObj = try DataModel()
                        
                        if let _id = (arr as AnyObject).value(forKey: "id") as? Int{
                            dataObj.id = _id
                        }
                        
                        if let _downloadurl = (arr as AnyObject).value(forKey: "download_url") as? String{
                            dataObj.download_url = _downloadurl
                        }
                        
                        resultDataModelArray.append(dataObj)
                    }
                    
                    debugPrint("Request API = ", apiUrl)
                    debugPrint("API Response = ",resultJson)
                    
                    
                    completionHendler(resultDataModelArray, nil, true)
                } else  {
                    completionHendler(emptyDataModelArray, error as NSError?, false)
                }
            } catch {
                completionHendler(emptyDataModelArray, error as NSError?, false)
            }
        }
        dataTask.resume()
    }
}

