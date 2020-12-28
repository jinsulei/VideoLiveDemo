//
//  XCRoom.swift
//  VideoLiveProgect
//
//  Created by iMusic_xc on 2020/12/24.
//

import UIKit
import HandyJSON

class XCRoom: HandyJSON {
    var room_id:String = ""
    var room_src:String = ""
    var vertical_src:String = ""
    var cate_id:String = ""
    var room_name:String = ""
    var vod_quality:String = ""
    var show_status:String = ""
    var show_time:String = ""
    var owner_uid:String = ""
    var specific_catalog:String = ""
    var specific_status:String = ""
    var credit_illegal:String = ""
    var is_white_list:String = ""
    var cur_credit:String = ""
    var low_credit:String = ""
    var nickname:String = ""
    var url:String = ""
    var game_url:String = ""
    var game_name:String = ""
    var game_icon_url:String = ""
    var show_details:String = ""
    var owner_avatar:String = ""
    var nrt:String = ""
    var owner_weight:String = ""
    var fans:String = ""
    var column_id:String = ""
    var cdnsWithName : Array<Any> = Array()
    var cate_limit : Dictionary<String, Any> = Dictionary()
    
    var open_full_screen:Int = 0
    var is_pass_player:Int = 0
    var isVertical:Bool = false
    var online:Int = 0
    
    required init() {}
}
