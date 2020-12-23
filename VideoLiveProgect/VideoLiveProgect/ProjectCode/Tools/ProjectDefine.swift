//
//  ProjectDefine.swift
//  VideoLiveProgect
//
//  Created by iMusic_xc on 2020/12/14.
//

import Foundation
import UIKit

let SERVER_BASE_URL = "http://capi.douyucdn.cn/api/v1/"


let SCRENT_WIDTH = UIScreen.main.bounds.width
let SCRENT_HEIGHT = UIScreen.main.bounds.height

let DEFAULT_COLOR = UIColor.init(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
let FOOT_VIEW_COLOR = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)

func RANDMCOLOR() -> UIColor {
    let red = CGFloat(arc4random()%256)/255
    let green = CGFloat(arc4random()%255)/255
    let blue = CGFloat(arc4random()%254)/255
    
    return UIColor.init(red: red, green: green, blue: blue, alpha: 1)
    
}

func RGBA(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> UIColor {
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

func RGB(r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor {
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}

//let RANDM_COLOR = UIColor.init(red: CGFloat(arc4random()%256)/255, green: CGFloat(arc4random()%255)/255, blue: CGFloat(arc4random()%254)/255, alpha: 1)

let IS_IPHONEX = (SCRENT_HEIGHT >= 812) ? true : false

let NAV_HEIGHT : CGFloat = IS_IPHONEX ? 88.0 : 64.0

let TABBAR_HEIGHT : CGFloat = IS_IPHONEX ? 49.0 + 34.0 : 49.0
