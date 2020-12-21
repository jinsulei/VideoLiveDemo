//
//  XCHomeViewController.swift
//  VideoLiveProgect
//
//  Created by iMusic_xc on 2020/12/14.
//

import UIKit

class XCHomeViewController: XCBaseViewController{
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        
        view.addSubview(self.pageContainView)
    }
    
    private lazy var pageContainView:XCPageContainView = {
        let pageview = XCPageContainView(frame: CGRect(x: 0, y: NAV_HEIGHT, width: SCRENT_WIDTH, height: SCRENT_HEIGHT - NAV_HEIGHT))
        pageview.dataSource = self
        pageview.delegate = self
        return pageview
    }()
    
    private lazy var pageTitleview: XCPageTitleView = {
        let titles = ["推荐","游戏","娱乐","去玩"]
        let pageTitleView = XCPageTitleView(frame: CGRect(x: 0, y: NAV_HEIGHT, width: SCRENT_WIDTH, height: 44),titles: titles)
        return pageTitleView
    }()
}
//处理pagetitleView
extension XCHomeViewController{
    
}
//处理导航条
extension XCHomeViewController{
    func setupNavbar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highlightedImageName: "Image_my_history_click")
        let searchItem = UIBarButtonItem(imageName: "btn_search", highlightedImageName: "btn_search_click")
        let qrItem = UIBarButtonItem(imageName: "Image_scan", highlightedImageName: "Image_scan_click")
        
        self.navigationItem.rightBarButtonItems = [historyItem,searchItem,qrItem]
    }
}

extension XCHomeViewController:XCPageContainViewDataSource,XCPageContainViewDelegate {
    func pageContainView(_ containView: XCPageContainView, itemForIndex atIndex: Int) -> UIViewController {
        let controller : UIViewController = UIViewController()
        controller.view.backgroundColor = UIColor.blue
        return controller
    }
    
    func pageContainView(_ containView: XCPageContainView, willScrollToIndex index: Int) {
        print("将要滑到第\(index)页")
    }
    func pageContainView(_ containView: XCPageContainView, didScrollToIndex index: Int) {
        print("滑到了第\(index)页")
    }
    
    func pageContainViewGetAllTitles(_ containView: XCPageContainView) -> [String] {
        return ["推荐","游戏","娱乐","去玩"]
    }
    
}
