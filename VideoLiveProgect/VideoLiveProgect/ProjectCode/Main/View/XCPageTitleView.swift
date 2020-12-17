//
//  XCPageTitleView.swift
//  VideoLiveProgect
//
//  Created by iMusic_xc on 2020/12/15.
//

import UIKit

class XCPageTitleView: UIView {

    var titles:[String]?
    var defaultItemWith : CGFloat
    
    lazy var titleCollectionView:UICollectionView = { [weak self] in
        let viewLayout = UICollectionViewFlowLayout.init()
        viewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: viewLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(XCTitlePageCollectionViewCell.self, forCellWithReuseIdentifier: "titleCell")
        
        return collectionView;
    }()
    
    lazy var lineView : UIView = {
        let linvew = UIView()
        linvew.backgroundColor = UIColor.orange
        return linvew
    }()
    
    init(frame: CGRect,titles : [String]) {
        defaultItemWith = frame.size.width/CGFloat(titles.count)
        super.init(frame: frame)
        self.titles = titles
        self.addSubview(self.titleCollectionView)
        self.titleCollectionView.frame = self.bounds
        
        setupLineView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView(){
        
    }
    
    func setupLineView()  {
        self.titleCollectionView.addSubview(self.lineView)
        
        lineView.frame = CGRect(x: (defaultItemWith-30)/2, y: self.frame.height-4.5, width: 30, height: 4)
        lineView.clipsToBounds = true
        lineView.layer.cornerRadius = 2
    }
}

extension XCPageTitleView : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titles?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: defaultItemWith, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0.1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:XCTitlePageCollectionViewCell  = collectionView.dequeueReusableCell(withReuseIdentifier: "titleCell", for: indexPath) as! XCTitlePageCollectionViewCell
//        cell.backgroundColor = RANDMCOLOR()
        cell.titleLabel.text = self.titles![indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? XCTitlePageCollectionViewCell
        
        let cellX = cell?.frame.origin.x ?? 0
        let cellWidth = cell?.frame.size.width ?? 0
        
        let offsetX = cellX + (cellWidth - 30)/2
        
        UIView.animate(withDuration: 0.16) {
            self.lineView.frame.origin.x = offsetX
        }
    }
    
}
