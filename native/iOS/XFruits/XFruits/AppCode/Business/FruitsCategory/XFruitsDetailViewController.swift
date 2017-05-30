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
        backgroundView.snp.makeConstraints { (make) in
            make.width.top.equalTo(self.view)
        }
        actionBarView.snp.makeConstraints { (make) in
            make.height.equalTo(45)
            make.top.equalTo(self.backgroundView.snp.bottom)
            make.width.bottom.equalTo(self.view)
        }
        
        backgroundView.addSubview(headerView)
        backgroundView.addSubview(commentView)
        backgroundView.addSubview(descriptionView)
        
        headerView.snp.makeConstraints { (make) in
            make.top.width.equalTo(self.backgroundView)
            make.bottom.equalTo(self.commentView.snp.top).offset(-10)
        }
        commentView.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp.bottom).offset(10)
            make.width.equalTo(self.backgroundView)
            make.bottom.equalTo(self.descriptionView.snp.top).offset(-10)
        }
        descriptionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.commentView.snp.bottom).offset(10)
            make.width.bottom.equalTo(self.backgroundView)
        }
        descriptionView.descBackgroundView.snp.makeConstraints { (make) in
            make.height.equalTo(self.backgroundView.snp.height).offset(-42)
        }
    }


}
