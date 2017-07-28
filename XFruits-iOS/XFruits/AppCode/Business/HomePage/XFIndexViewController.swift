//
//  XFIndexViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD


class XFIndexViewController: XFBaseViewController {
    
    lazy var pagerView:XFViewPager = {
        let imageUrls = ["http://bizhi.zhuoku.com/2011/07/20/Benbenmiao/Benbenmiao130.jpg",
                         "http://img3.iqilu.com/data/attachment/forum/201308/22/161503hoakfzi7fqkk7711.jpg",
                         "http://www.33lc.com/article/UploadPic/2012-8/20128179522243094.jpg"]
        let pagerView = XFViewPager(source: imageUrls, placeHolder: nil)
            pagerView.pagerDidClicked = {(index:Int) -> Void in
                dPrint("\(index) 号被点击")
                MBProgressHUD.showError("链接没有准备好呢，小果拾表示骚瑞~")
            }
        return pagerView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.imageWithNamed("scan-icon"),
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(onScanItemClick))
        
    
        self.view.addSubview(pagerView)
        pagerView.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view).offset(0)
            make.width.equalTo(self.view)
            // TODO: 提前约定好宽高比
            make.height.equalTo(floor(XFConstants.UI.deviceWidth/(1920/1080)))
            
        })
        
    }
    
    @objc private func onScanItemClick(){
        
        MBProgressHUD.showMessage("小果拾表示这个功能还没想好怎么做...") {
            dPrint("扫描：小果拾表示这个功能还没想好怎么做...")
        }
        
    }

}

