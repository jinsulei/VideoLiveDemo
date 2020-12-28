//
//  XCLiveViewController.swift
//  VideoLiveProgect
//
//  Created by iMusic_xc on 2020/12/14.
//

import UIKit

class XCLiveViewController: XCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let button :UIButton = UIButton(type: .custom)
        button.frame = CGRect(x: 100, y: 100, width: 80, height: 40)
        button.setTitle("按钮", for: .normal)
        button.backgroundColor = UIColor.gray
        button.addTarget(self, action: #selector(toNextView), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
    
    @objc func toNextView()  {
        let controller : XCRoomHorizontalViewController = XCRoomHorizontalViewController()
        self.pushViewController(controller)
        
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
