//
//  XCYanZhiCollectionViewCell.swift
//  VideoLiveProgect
//
//  Created by iMusic_xc on 2020/12/22.
//

import UIKit
import Kingfisher

class XCYanZhiCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var coverImageView:UIImageView?
    @IBOutlet weak var titleLabel:UILabel?
    @IBOutlet weak var localtionBtn:UIButton?
    @IBOutlet weak var onlineNumLabel:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        coverImageView?.layer.cornerRadius = 4
        coverImageView?.layer.masksToBounds = true
    }
    
    var anchorModel:XCAnchorModel? {
        didSet{
            self.titleLabel?.text = anchorModel?.nickname
            let number = anchorModel?.online ?? 0
            
            if number>=10000 {
                self.onlineNumLabel?.text = "\(number/10000)人在线"
            }else{
                self.onlineNumLabel?.text = "\(number)人在线"
            }
            self.coverImageView?.kf.setImage(with: URL(string: anchorModel!.vertical_src))
        }
    }
    
    
}
