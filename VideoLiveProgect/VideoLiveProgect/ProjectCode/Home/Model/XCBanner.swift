//
//  XCBanner.swift
//  VideoLiveProgect
//
//  Created by iMusic_xc on 2020/12/24.
//

import UIKit
import HandyJSON

class XCBanner: HandyJSON {
    var title:String = ""
    var pic_url:String = ""
    var tv_pic_url:String = ""
    var room:XCRoom = XCRoom()
    
    
    var id:Int = 0
    var main_id:Int = 0
    var source:Int = 0
    var oa_source:Int = 0

    required init() {}
}
