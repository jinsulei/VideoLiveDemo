//
//  XCHomeViewController.swift
//  VideoLiveProgect
//
//  Created by iMusic_xc on 2020/12/14.
//

import UIKit

class XCHomeViewController: XCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        
        view.addSubview(self.pageTitleview)
    }
    
    
    
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


