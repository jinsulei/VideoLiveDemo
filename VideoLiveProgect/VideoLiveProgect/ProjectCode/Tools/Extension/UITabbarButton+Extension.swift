//
//  UITabbarButton+Extension.swift
//  VideoLiveProgect
//
//  Created by iMusic_xc on 2020/12/15.
//

import Foundation
import UIKit

extension UIBarButtonItem{
    public convenience init(imageName:String,highlightedImageName:String = "") {
        
        let rightBtn = UIButton(type: .custom)
        rightBtn.frame = CGRect(origin: rightBtn.frame.origin, size: CGSize(width: 44, height: 44))
        if imageName != "" {
            rightBtn.setImage(UIImage(named: imageName), for: .normal)

        }
        if highlightedImageName != "" {
            rightBtn.setImage(UIImage(named: highlightedImageName), for: .highlighted)
        }
        self.init(customView:rightBtn)
        
    }
}
