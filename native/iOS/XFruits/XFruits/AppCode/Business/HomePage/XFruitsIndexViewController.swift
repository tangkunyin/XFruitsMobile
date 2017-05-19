//
//  XFruitsIndexViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/4/9.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit

class XFruitsIndexViewController: XFruitsBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    
        let imageUrls = ["http://desk.fd.zol-img.com.cn/g5/M00/02/0B/ChMkJ1bK1fSIOoJHAAFWaDrqe94AALJsANLr7kAAVaA928.jpg",
                         "http://b.zol-img.com.cn/desk/bizhi/image/2/960x600/1359447948761.jpg",
                         "http://www.xs-a.com/userfiles/2016510271041230.08.jpg",
                         "http://i2.download.fd.pchome.net/t_960x600/g1/M00/08/1D/ooYBAFOnwieIezFzAAKCDjZ0CaoAABoWgCQspUAAoIm250.jpg"];
        
        
        let pagerView = XFruitsViewPager(source: imageUrls, placeHolder: nil)
        pagerView.pagerDidClicked = {(index:Int) -> Void in
            print("\(index) 号被点击")
        }
        
        
        self.view.addSubview(pagerView)

        pagerView.snp.makeConstraints({ (make) in
            make.top.equalTo(0)
            make.height.equalTo(204)
            make.centerX.equalTo(self.view)
        })
        
        // 跳转到登录页面
//        let loginVC  = XFruitsUserLoginViewController()
//        let nav = UINavigationController(rootViewController:loginVC)
//
//        self.present(nav, animated: true, completion: nil)

        
    }

    

}
