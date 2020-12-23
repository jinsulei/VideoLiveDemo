//
//  XCReqRecommendViewModel.swift
//  VideoLiveProgect
//
//  Created by iMusic_xc on 2020/12/23.
//

import UIKit
import HandyJSON



class XCReqRecommendViewModel {

    lazy var recommendList:Array<AnyObject> = [XCAnchorModel]()
}

//mark : 数据请求
extension XCReqRecommendViewModel{
    func loadRecommendData(_ finshCallback :@escaping ()->())  {
        
        let parameter = ["limit":"10", "offset":"0", "time":NSDate.getCurrentIntervalTimeStr()] as [String:AnyObject]
        
        XCNetworkingManager.postRequest(urlStr: "getbigDataRoom", parameters: parameter) { (result) in
            guard let result = result as? [String:AnyObject] else{
                print("数据解析失败")
//                print(result.error)
                return
            }

            let baseModel = JSONDeserializer<XCBaseModel>.deserializeFrom(dict: result)
            let anchorModelArray = JSONDeserializer<XCAnchorModel>.deserializeModelArrayFrom(array: baseModel?.data)
            for model in anchorModelArray!{
                self.recommendList.append(model!)
            }
            
            finshCallback()
        }
    }
}
