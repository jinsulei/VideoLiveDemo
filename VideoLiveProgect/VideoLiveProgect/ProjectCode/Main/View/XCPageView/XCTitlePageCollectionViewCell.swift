//
//  XCTitlePageCollectionViewCell.swift
//  VideoLiveProgect
//
//  Created by iMusic_xc on 2020/12/16.
//

import UIKit

class XCTitlePageCollectionViewCell: UICollectionViewCell {
    open lazy var titleLabel:UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(self.titleLabel)
        self.titleLabel.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: frame.size)
        
    }
    
    func updateCellWithDisplay(isDisplay:Bool)  {
        self.titleLabel.textColor = isDisplay ? UIColor.orange : UIColor.black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
