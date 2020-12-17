//
//  XCTabBarViewController.swift
//  VideoLiveProgect
//
//  Created by iMusic_xc on 2020/12/14.
//

import UIKit

class XCTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor.orange
        
        UITabBar.appearance().clipsToBounds = true
        
        let homeNavController = UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController()
        let liveMavController = UIStoryboard(name: "Live", bundle: nil).instantiateInitialViewController()
        let followNavController = UIStoryboard(name: "Follow", bundle: nil).instantiateInitialViewController()
        let profilenavController = UIStoryboard(name: "Profile", bundle: nil).instantiateInitialViewController()
        setViewControllers([homeNavController!,liveMavController!,followNavController!,profilenavController!], animated: false)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
