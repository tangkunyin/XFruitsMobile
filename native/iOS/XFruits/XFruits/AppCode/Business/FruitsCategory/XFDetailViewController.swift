//
//  XFDetailViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD

class XFDetailViewController: XFBaseSubViewController {
    
    var prodId:Int?
    var _detailData:ProductDetail? {
        didSet {
            if let dataSource = _detailData {
                headerView.dataSource = dataSource
                commentView.dataSource = dataSource
                descriptionView.dataSource = dataSource
            }
        }
    }
    
    lazy var request:XFCommonService = {
        let serviceRequest = XFCommonService()
        return serviceRequest
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "产品详情页"
        view.backgroundColor = UIColor.white
        
        makePagingViewConstrains()
        
        weak var weakSelf = self
        if let prodId = prodId {
            request.getProductDetail(pid: prodId, { (data) in
                if let detailData = data as? ProductDetail {
                    weakSelf?._detailData = detailData
                }
            })
        }
    }
    
    private lazy var backgroundView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = XFConstants.Color.commonBackground
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var actionBarView: XFDetailActionBarView = {
        let view = XFDetailActionBarView()
        return view
    }()
    
    
    /// 轮播及商品信息
    private lazy var headerView: XFDetailHeaderView = {
        let view = XFDetailHeaderView()
        return view
    }()
    
    /// 评论
    private lazy var commentView: XFDetailCommentView = {
        let view = XFDetailCommentView()
        return view
    }()
    
    /// 详情图展
    private lazy var descriptionView: XFDetailDescriptionView = {
        let view = XFDetailDescriptionView()
        return view
    }()
    
    private func makePagingViewConstrains(){
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
        }
        commentView.snp.makeConstraints { (make) in
            make.width.equalTo(self.backgroundView)
            make.top.equalTo(self.headerView.snp.bottom).offset(10)
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

