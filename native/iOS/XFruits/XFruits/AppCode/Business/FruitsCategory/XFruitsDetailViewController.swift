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
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    /// 商品概览
    private lazy var pagingOverview: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    /// 商品详情
    private lazy var pagingDetail: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "产品详情页"
        view.backgroundColor = UIColor.white
        
        makePagingViewConstrains()
    }
    
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
        backgroundView.addSubview(pagingOverview)
        backgroundView.addSubview(pagingDetail)
        pagingOverview.snp.makeConstraints { (make) in
            make.size.top.equalTo(self.backgroundView)
            make.bottom.equalTo(pagingDetail.snp.top)
        }
        pagingDetail.snp.makeConstraints { (make) in
            make.size.bottom.equalTo(self.backgroundView)
            make.top.equalTo(pagingOverview.snp.bottom)
        }
        makesubViewsConstrains()
    }
    
    private func makesubViewsConstrains(){
        pagingOverview.addSubview(headerView)
        pagingOverview.addSubview(commentView)
        pagingDetail.addSubview(descriptionView)
        headerView.snp.makeConstraints { (make) in
            make.top.width.equalTo(self.pagingOverview)
            make.bottom.equalTo(self.commentView.snp.top).offset(-10)
        }
        commentView.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp.bottom).offset(10)
            make.width.bottom.equalTo(self.pagingOverview)
        }
        descriptionView.snp.makeConstraints { (make) in
            make.width.top.bottom.equalTo(self.pagingDetail)
        }
        descriptionView.descBackgroundView.snp.makeConstraints { (make) in
            make.height.equalTo(self.pagingDetail.snp.height).offset(-42)
        }
    }


}
