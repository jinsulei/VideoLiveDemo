//
//  XCNetworkingManager.swift
//  VideoLiveProgect
//
//  Created by iMusic_xc on 2020/12/23.
//

import Foundation
import Alamofire

class XCNetworkingManager {
    
    class func postRequest(urlStr:String , parameters:Dictionary<String,AnyObject>?=nil,responseCallBack: @escaping (_ result:Any)->()){
        let reqUrl:URL = URL.init(string: "\(SERVER_BASE_URL)\(urlStr)")!
        let headersDic : HTTPHeaders = NSMutableDictionary(dictionary: SessionManager.defaultHTTPHeaders) as! HTTPHeaders
        
        
        Alamofire.request(reqUrl, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headersDic ).responseJSON(completionHandler: { (response) in
            guard let result = response.result.value as? [String:AnyObject] else{
                print(response.result.error as Any)
                return
            }
            responseCallBack(result)
        })
    }
}
