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
    
    private var loopImages: Array<XFIndexLoopImage>? {
        didSet {
            if let images = loopImages {
                var imageUrls: Array<String> = []
                for item in images {
                    imageUrls.append(item.cover)
                }
                if imageUrls.count > 0 {
                    pagerView.dataSource = imageUrls
                }
            }
        }
    }
    
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
     
        weak var weakSelf = self
        request.getLoopImages { (result) in
            weakSelf?.loopImages = result as? Array
        }
    }
    
    @objc private func onScanItemClick(){
        
        MBProgressHUD.showMessage("小果拾表示这个功能还没想好怎么做...") {
            dPrint("扫描：小果拾表示这个功能还没想好怎么做...")
        }
        
    }
    
    
    
    
    private lazy var request: XFNewsInfoService = {
        return XFNewsInfoService()
    }()
    
    private lazy var pagerView:XFViewPager = {
        let pagerView = XFViewPager(source: [""], placeHolder: "Loading-white")
        pagerView.pagerDidClicked = {(index:Int) -> Void in
            dPrint("\(index) 号被点击")
            MBProgressHUD.showError("链接没有准备好呢，小果拾表示骚瑞~")
        }
        return pagerView
    }()

}

