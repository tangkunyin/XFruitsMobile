//
//  XFruitsDetailViewController.swift
//  XFruits
//
//  Created by tangkunyin on 28/05/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD

class XFruitsDetailViewController: XFruitsBaseSubViewController {

    private lazy var backgroundView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = XFConstants.Color.commonBackground
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    
    private lazy var headerView: XFDetailHeaderView = {
        let view = XFDetailHeaderView()
        return view
    }()
    
    private lazy var commentView: XFDetailCommentView = {
        let view = XFDetailCommentView()
        return view
    }()
    
    private lazy var descriptionView: XFDetailDescriptionView = {
        let view = XFDetailDescriptionView()
        return view
    }()
    
    private lazy var actionBarView: XFDetailActionBarView = {
        let view = XFDetailActionBarView()
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "产品详情页"
        view.backgroundColor = UIColor.white
        
        
        makeViewConstrains()
    }
    
    private func makeViewConstrains(){
        view.addSubview(backgroundView)
        view.addSubview(actionBarView)
        backgroundView.addSubview(headerView)
//        backgroundView.addSubview(commentView)
//        backgroundView.addSubview(descriptionView)
        
        backgroundView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.view)
            make.bottom.equalTo(self.actionBarView.snp.top)
        }
        actionBarView.snp.makeConstraints { (make) in
            make.height.equalTo(45)
            make.top.equalTo(self.backgroundView.snp.bottom)
            make.left.right.bottom.equalTo(self.view)
        }
        
        headerView.snp.makeConstraints { (make) in
            make.top.width.equalTo(self.backgroundView)
//            make.height.equalTo(400)
        }
        
        
//        descriptionView.snp.makeConstraints { (make) in
//            make.left.right.bottom.equalTo(self.backgroundView)
//        }
        
        
    }

    

}
