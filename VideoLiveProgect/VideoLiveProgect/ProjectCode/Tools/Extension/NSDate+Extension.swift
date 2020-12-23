//
//  NSDate+Extension.swift
//  VideoLiveProgect
//
//  Created by iMusic_xc on 2020/12/23.
//

import Foundation

extension NSDate{
   static func getCurrentIntervalTimeStr() -> String {
        let time = Int(NSDate().timeIntervalSince1970)
        return "\(time)"
    }
}
