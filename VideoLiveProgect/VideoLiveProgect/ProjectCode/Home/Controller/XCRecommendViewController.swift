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
        
//        collection.register(XCNormalCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        collection.register(UINib(nibName: "XCNormalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionCell")
        collection.register(UINib(nibName: "XCYanZhiCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "yanzhiCollectionCell")
//        collection.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "collectionHeader")
        collection.register(UINib(nibName: "XCRecommendHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "collectionHeader")
        
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
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recommendData.recommendList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width : CGFloat = (collectionView.frame.width - 30)/2
        var height: CGFloat = 0
        if indexPath.section == 0 {
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
        return UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "collectionHeader", for: indexPath)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "yanzhiCollectionCell", for: indexPath) as! XCYanZhiCollectionViewCell
            cell.anchorModel = self.recommendData.recommendList[indexPath.item] as? XCAnchorModel
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
            return cell
        }
        
    }
    
    
}
