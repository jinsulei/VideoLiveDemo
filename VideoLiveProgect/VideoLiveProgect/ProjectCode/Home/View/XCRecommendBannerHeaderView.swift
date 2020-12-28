//
//  XCRecommendBannerHeaderView.swift
//  VideoLiveProgect
//
//  Created by iMusic_xc on 2020/12/24.
//

import UIKit
import FSPagerView

class XCRecommendBannerHeaderView: UICollectionViewCell {
    var dataList:Array<XCBanner> = []{
        didSet{
            let currentIndex = self.bannerView.currentIndex
            
            self.bannerView.reloadData()
            if currentIndex != 0 {
                self.bannerView.scrollToItem(at: currentIndex, animated: false)
            }
        }
    }
    
    lazy var bannerView : FSPagerView = {
        let bannerView : FSPagerView = FSPagerView.init(frame: CGRect.zero)
        bannerView.delegate = self
        bannerView.dataSource = self
        bannerView.automaticSlidingInterval = 4
        bannerView.isScrollEnabled = true
        bannerView.isInfinite = true

        bannerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "FSPagerViewCell")
        return bannerView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubView()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension XCRecommendBannerHeaderView{
    func setupSubView()  {
        self.addSubview(self.bannerView)
        self.bannerView.frame = self.bounds
    }
}

extension XCRecommendBannerHeaderView : FSPagerViewDelegate,FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.dataList.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell =  pagerView.dequeueReusableCell(withReuseIdentifier: "FSPagerViewCell", at: index)
        let banner = self.dataList[index]
        
        cell.imageView?.kf.setImage(with: URL(string: banner.pic_url))
        cell.imageView?.contentMode = .scaleAspectFill
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
    }
}
