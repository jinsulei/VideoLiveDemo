//
//  XCPageContainView.swift
//  VideoLiveProgect
//
//  Created by iMusic_xc on 2020/12/17.
//

import UIKit

protocol XCPageContainViewDataSource : NSObjectProtocol {
    
    func pageContainViewGetAllTitles(_ containView:XCPageContainView) -> [String]
    
    func pageContainView(_ containView:XCPageContainView , itemForIndex atIndex:Int) -> UIViewController
}

@objc protocol XCPageContainViewDelegate {
    @objc optional func pageContainView(_ containView:XCPageContainView ,willScrollToIndex index:Int)
    @objc optional func pageContainView(_ containView:XCPageContainView ,didScrollToIndex index:Int)
}

class XCPageContainView: UIView {
    weak open var delegate : XCPageContainViewDelegate?
    private var _dataSource : XCPageContainViewDataSource?
    var currentIndex : Int = 0
    var willScrollIndex : Int = 0
    var startOffsetX : CGFloat = 0
    var startLineOffsetX : CGFloat = 0
    
    var lineWidth : CGFloat = 0
    var lineOffsetWidth : CGFloat = 0
    var currentCell : UICollectionViewCell!
    var nextCell :UICollectionViewCell!
    
    

    weak open var dataSource : XCPageContainViewDataSource? {
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
        self.pageContentView.frame = CGRect(x: 0, y: self.pageTitleview.frame.maxY, width: frame.width, height: self.frame.height-self.pageTitleview.frame.maxY)
        self.lineOffsetWidth = self.pageTitleview.linewViewWidth
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var pageTitleview: XCPageTitleView = {
        self.titles = self.dataSource!.pageContainViewGetAllTitles(self)
        let pageTitleView = XCPageTitleView(frame: CGRect(x: 0, y: 0, width: SCRENT_WIDTH, height: 44),titles: titles!)
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
    
    private lazy var viewControllersDic : NSDictionary = {
        let dic = NSMutableDictionary()
        return dic
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
        if indexPath.row == 0 && (self.viewControllersDic["0"] == nil) {
            self.perform(#selector(UIScrollViewDelegate.scrollViewDidEndDecelerating(_:)), with: collectionView, afterDelay: 0.1)
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        willScrollIndex = indexPath.row
//        nextCell = self.pageTitleview.titleCollectionView.cellForItem(at: indexPath)
        startOffsetX = collectionView.contentOffset.x
        startLineOffsetX = self.pageTitleview.lineView.frame.minX
//        lineWidth = self.pageTitleview.linewViewWidth
//
//        if (nextCell != nil) {
//            if (currentCell == nil)  {
//                currentCell = self.pageTitleview.titleCollectionView.cellForItem(at: IndexPath.init(row: currentIndex, section: 0))
//            }
//            lineOffsetWidth = ((nextCell?.frame.width)! + (currentCell?.frame.width)!)/2 + self.pageTitleview.linewViewWidth
//        }
//        print(nextCell?.frame ?? CGRect.zero)
        
        if let aDelegate = self.delegate {
            aDelegate.pageContainView!(self, willScrollToIndex: indexPath.row)
        }
        
        if let viewConntroller:UIViewController = self.viewControllersDic["\(indexPath.row)"] as? UIViewController {
            viewConntroller.view.removeFromSuperview()
            cell.addSubview(viewConntroller.view)
            viewConntroller.view.frame = cell.bounds
        }else{
            if let aDatasource = self.dataSource {
                let controller = aDatasource.pageContainView(self, itemForIndex: indexPath.row)
                self.viewControllersDic.setValue(controller, forKey: "\(indexPath.row)")
                controller.view.removeFromSuperview()
                cell.addSubview(controller.view)
                controller.view.frame = cell.bounds
            }
        }
    }
    
}

extension XCPageContainView : UIScrollViewDelegate{

    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        startOffsetX = scrollView.contentOffset.x
//        startLineOffsetX = self.pageTitleview.lineView.frame.minX
//        lineWidth = self.pageTitleview.linewViewWidth
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let rate = (scrollView.contentOffset.x - startOffsetX)/self.frame.width
//        if rate>=0 {//向右滑
//
//            if lineWidth > lineOffsetWidth{
//                let rateOffset = (rate-0.5) * lineOffsetWidth
//                self.pageTitleview.lineView.frame.size.width = lineWidth - rateOffset - (nextCell.frame.width - self.pageTitleview.linewViewWidth)/2
//                self.pageTitleview.lineView.frame.origin.x =  startLineOffsetX + rateOffset + (nextCell.frame.width - self.pageTitleview.linewViewWidth)/2
//            }else{
//                self.pageTitleview.lineView.frame.size.width = self.pageTitleview.linewViewWidth + rate * lineOffsetWidth
//                lineWidth = self.pageTitleview.lineView.frame.size.width;
//            }
//        }else{//向左滑
//            if lineWidth >= lineOffsetWidth {
//                self.pageTitleview.lineView.frame.size.width = lineWidth + rate * lineOffsetWidth + self.pageTitleview.linewViewWidth
//                self.pageTitleview.lineView.frame.origin.x =  nextCell.frame.minX + (nextCell.frame.width - self.pageTitleview.linewViewWidth)/2
//            }else{
//                let rateOffset = rate * lineOffsetWidth
//                self.pageTitleview.lineView.frame.origin.x =  startLineOffsetX + rateOffset
//                self.pageTitleview.lineView.frame.size.width = self.pageTitleview.linewViewWidth - rate * lineOffsetWidth
//                lineWidth = self.pageTitleview.lineView.frame.size.width;
//            }
//        }

        
        self.pageTitleview.lineView.frame.origin.x =  startLineOffsetX + rate * self.pageTitleview.defaultItemWith
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
        
        currentIndex = Int(scrollView.contentOffset.x / self.frame.width)
        
        let containCell = self.pageContentView.cellForItem(at: IndexPath.init(row: currentIndex, section: 0))
        
//        UIView.animate(withDuration: 0.2) {[weak self] in
//            self?.pageTitleview.lineView.frame.size.width = self?.pageTitleview.linewViewWidth ?? 0
//            self?.pageTitleview.lineView.frame.origin.x =  (self?.currentCell.frame.minX)! + ((self?.currentCell.frame.width)! - (self?.pageTitleview.linewViewWidth)!)/2
//        }
        self.pageTitleview.didScrollToItemAtIndex(atIndex: currentIndex)
        if let aDelegate = self.delegate {
            aDelegate.pageContainView!(self, didScrollToIndex: currentIndex)
        }
        
//        if let viewConntroller:UIViewController = self.viewControllersDic["\(currentIndex)"] as? UIViewController {
//            viewConntroller.view.removeFromSuperview()
//            containCell!.addSubview(viewConntroller.view)
//            viewConntroller.view.frame = containCell!.bounds
//        }else{
//            if let aDatasource = self.dataSource {
//                let controller = aDatasource.pageContainView(self, itemForIndex: currentIndex)
//                self.viewControllersDic.setValue(controller, forKey: "\(currentIndex)")
//                controller.view.removeFromSuperview()
//                containCell!.addSubview(controller.view)
//                controller.view.frame = containCell!.bounds
//            }
//        }
        
    }
}
