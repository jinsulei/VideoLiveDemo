//
//  XCRecommendViewController.swift
//  VideoLiveProgect
//
//  Created by iMusic_xc on 2020/12/22.
//

import UIKit

class XCRecommendViewController: XCBaseViewController {

    lazy var recommendCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collection : UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        collection.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collection.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: TABBAR_HEIGHT, right: 0);
        collection.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: TABBAR_HEIGHT, right: 0);
        
        collection.register(UINib(nibName: "XCNormalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionCell")
        collection.register(UINib(nibName: "XCYanZhiCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "yanzhiCollectionCell")
        collection.register(UINib(nibName: "XCRecommendHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "collectionHeader")
//        collection.register(XCRecommendBannerHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "XCRecommendBannerHeaderView")
        collection.register(XCRecommendBannerHeaderView.self, forCellWithReuseIdentifier: "XCRecommendBannerHeaderView")
        
        return collection
    }()
    
    
    fileprivate lazy var recommendData : XCReqRecommendViewModel = XCReqRecommendViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRecommendData()
        setupUI()
    }
}

extension XCRecommendViewController{
    func setupUI()  {
        
        self.view.addSubview(self.recommendCollectionView)
        self.recommendCollectionView.frame = CGRect(x: 0, y: 0, width: SCRENT_WIDTH, height: self.view.frame.height)
        
    }
}

//mark: 网络数据
extension XCRecommendViewController{
    func getRecommendData(){
        recommendData.loadRecommendData {
            self.recommendCollectionView.reloadData()
        }
    }
}
 
extension XCRecommendViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return self.recommendData.recommendList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.width * 0.417)
        }
        
        let width : CGFloat = (collectionView.frame.width - 30)/2
        var height: CGFloat = 0
        if indexPath.section == 1 {
            height = width*7/9
        }else{
            height = width + 36
        }
        return CGSize(width: width, height: height)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section==0 {
            return UIEdgeInsets.zero
        }
        return UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize.zero
        }
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if indexPath.section == 0 {
//
//            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "XCRecommendBannerHeaderView", for: indexPath) as! XCRecommendBannerHeaderView
//            header.dataList = self.recommendData.bannerList as! [XCBanner]
//            return header
//        }
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "collectionHeader", for: indexPath)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "XCRecommendBannerHeaderView", for: indexPath) as! XCRecommendBannerHeaderView
            cell.dataList = self.recommendData.bannerList as! [XCBanner]
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "yanzhiCollectionCell", for: indexPath) as! XCYanZhiCollectionViewCell
            cell.anchorModel = self.recommendData.recommendList[indexPath.item] as? XCAnchorModel
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
        }else{
            let anchorModel = self.recommendData.recommendList[indexPath.item] as? XCAnchorModel
            if anchorModel?.isVertical != true {
                let roomContoller : XCRoomHorizontalViewController = XCRoomHorizontalViewController()
                roomContoller.hidesBottomBarWhenPushed = true
                self.pushViewController(roomContoller)
            }else{
                let roomContoller : XCRoomVerticalViewController = XCRoomVerticalViewController()
                self.present(roomContoller, animated: true) {
                    
                }
            }
        }
    }
}
