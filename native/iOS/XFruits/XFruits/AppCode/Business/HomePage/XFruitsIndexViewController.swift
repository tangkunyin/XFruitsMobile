//
//  XFruitsIndexViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/4/9.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD

class XFruitsIndexViewController: XFruitsBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.imageWithNamed("scan-icon"),
                                                                style: .plain,
                                                               target: self,
                                                               action: #selector(onScanItemClick))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.imageWithNamed("msg-icon"),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(onMessageItemClick))
        
    
        let imageUrls = ["http://desk.fd.zol-img.com.cn/g5/M00/02/0B/ChMkJ1bK1fSIOoJHAAFWaDrqe94AALJsANLr7kAAVaA928.jpg",
                         "http://b.zol-img.com.cn/desk/bizhi/image/2/960x600/1359447948761.jpg",
                         "http://www.xs-a.com/userfiles/2016510271041230.08.jpg",
                         "http://i2.download.fd.pchome.net/t_960x600/g1/M00/08/1D/ooYBAFOnwieIezFzAAKCDjZ0CaoAABoWgCQspUAAoIm250.jpg"];
        
        
        let pagerView = XFruitsViewPager(source: imageUrls, placeHolder: nil)
        pagerView.pagerDidClicked = {(index:Int) -> Void in
            print("\(index) 号被点击")
            MBProgressHUD.showError("点个毛线啊，链接都没有")
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
    
    @objc private func onScanItemClick(){
        
        MBProgressHUD.showMessage("扫描毛线啊...") {
            print("扫描毛线啊")
        }
    }
    
    @objc private func onMessageItemClick(){
        
        MBProgressHUD.loaddingWithMessage("玩儿命加载中...")
        
    }

    

}
