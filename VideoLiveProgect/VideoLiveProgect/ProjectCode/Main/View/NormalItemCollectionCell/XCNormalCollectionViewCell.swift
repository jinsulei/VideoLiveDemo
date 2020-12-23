//
//  XCNormalCollectionViewCell.swift
//  VideoLiveProgect
//
//  Created by iMusic_xc on 2020/12/22.
//

import UIKit

class XCNormalCollectionViewCell: UICollectionViewCell {

    @IBOutlet var coverImageView : UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        coverImageView?.layer.cornerRadius = 4
        coverImageView?.layer.masksToBounds = true
        // Initialization code
    }

}
