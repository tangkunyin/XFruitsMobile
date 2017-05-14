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

    
        let imageUrls = ["https://shuoit.net/img/2017/hexo-blog-basic.jpg",
                         "https://shuoit.net/img/2017/free-mac-usefull-tools.jpg",
                         "https://shuoit.net/images/rssFeed-bg.jpg"];
        
        let pagerView = XFruitsViewPager.init(source: imageUrls, placeHolder: nil)
        
        self.view.addSubview(pagerView!)

        pagerView?.snp.makeConstraints({ (make) in
            make.size.height.equalTo(150)
        })
        
    }

    

}
