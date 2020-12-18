//
//  XCPageContainView.swift
//  VideoLiveProgect
//
//  Created by iMusic_xc on 2020/12/17.
//

import UIKit

protocol XCPageContainViewDataSource : NSObjectProtocol {
    
    func pageContainViewGetAllTitles(_ containView:XCPageContainView) -> [String]
}

class XCPageContainView: UIView {
    weak var delegate : XCPageContainViewDataSource?
    private var _dataSource : XCPageContainViewDataSource?
    var currentIndex : Int = 0
    var willScrollIndex : Int = 0
    var startOffsetX : CGFloat = 0
    var startLineOffsetX : CGFloat = 0

    var dataSource : XCPageContainViewDataSource {
        set{
            self._dataSource = newValue
            setupSubView()
        }
        get{
            return self._dataSource!
        }
    }
    
    
    var titles:[String]?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        
    }
    
    func setupSubView()  {
        self.addSubview(self.pageTitleview)
        self.addSubview(self.pageContentView)
        self.pageContentView.frame = CGRect(x: 0, y: self.pageTitleview.frame.maxY, width: frame.width, height: frame.height-self.pageTitleview.frame.maxY)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var pageTitleview: XCPageTitleView = {
        self.titles = self.dataSource.pageContainViewGetAllTitles(self)
        let pageTitleView = XCPageTitleView(frame: CGRect(x: 0, y: NAV_HEIGHT, width: SCRENT_WIDTH, height: 44),titles: titles!)
        pageTitleView.didSelectedTitleBlock = {[weak self] indexPath in
            self!.startLineOffsetX = pageTitleView.lineView.frame.minX
            self!.startOffsetX = self!.pageContentView.contentOffset.x
 
            self!.pageContentView.scrollToItem(at: indexPath as IndexPath, at: .top, animated: true)
            self?.currentIndex = indexPath.row
        }
        return pageTitleView
    }()
    
    private lazy var pageContentView:UICollectionView = {[weak self] in
        let viewLayout = UICollectionViewFlowLayout.init()
        viewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: viewLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "contentCell")
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView;
    }()
}

//处理pageTitle
extension XCPageContainView {
    func setupTitleView(){
        
        
    }
    
    
}

extension XCPageContainView : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.titles?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "contentCell", for: indexPath)
        cell.backgroundColor = RANDMCOLOR()
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        willScrollIndex = indexPath.row
    }
    
}

extension XCPageContainView : UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
        startLineOffsetX = self.pageTitleview.lineView.frame.minX
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let rate = (scrollView.contentOffset.x - startOffsetX)/self.frame.width
        if rate>0 {//向右滑
            
            if self.pageTitleview.lineView.frame.size.width >= self.pageTitleview.defaultItemWith{
                self.pageTitleview.lineView.frame.origin.x =  startLineOffsetX + rate * self.pageTitleview.defaultItemWith
                self.pageTitleview.lineView.frame.size.width =  self.pageTitleview.defaultItemWith - rate * self.pageTitleview.lineView.frame.origin.x
            }else{
                self.pageTitleview.lineView.frame.size.width =  startLineOffsetX + rate * self.pageTitleview.defaultItemWith
            }
        }else{//向左滑
            
        }
        //向右滑

//            self.pageTitleview.lineView.frame.origin.x =  startLineOffsetX + rate * self.pageTitleview.defaultItemWith
            

    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
        
        currentIndex = Int(scrollView.contentOffset.x / self.frame.width)
    }
}
