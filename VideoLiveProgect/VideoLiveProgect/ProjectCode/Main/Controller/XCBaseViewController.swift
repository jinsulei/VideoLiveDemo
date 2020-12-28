//
//  XCBaseViewController.swift
//  VideoLiveProgect
//
//  Created by iMusic_xc on 2020/12/14.
//

import UIKit

class XCBaseViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func pushViewController(_ controller:XCBaseViewController)  {
        controller.hidesBottomBarWhenPushed = true
        var nav = self.navigationController
        if (nav == nil) {
            let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            nav = (app.tabbarController?.viewControllers![(app.tabbarController?.selectedIndex)!] as! UINavigationController)
        }
        if nav != nil {
            nav?.pushViewController(controller, animated: true)
        }
    }
}
