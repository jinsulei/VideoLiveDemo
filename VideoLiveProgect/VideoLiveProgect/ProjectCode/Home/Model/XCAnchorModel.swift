//
//  XCAnchorModel.swift
//  VideoLiveProgect
//
//  Created by iMusic_xc on 2020/12/23.
//

import UIKit
import HandyJSON

class XCAnchorModel: HandyJSON {
    
    var show_time:String = ""
    var recomType:String = ""
    var vertical_src:String = ""
    var avatar_small:String = ""
    var room_src:String = ""
    var room_name:String = ""
    var game_name:String = ""
    var child_id:String = ""
    var ranktype:String = ""
    var rpos:String = ""
    var nickname:String = ""
    var avatar_mid:String = ""
    var jumpUrl:String = ""
    
    var room_id:Int = 0
    var hn:Int = 0
    var push_ios:Int = 0
    var cate_id:Int = 0
    var isVertical:Bool = false
    var online:Int = 0
    var push_nearby:Int = 0
    
    required init() {}
    
}
