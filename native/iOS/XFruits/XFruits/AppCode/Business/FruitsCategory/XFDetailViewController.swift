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
                descriptionView.dataSource = dataSource
                var hasComments = false
                if let comments = dataSource.commentList, comments.count > 1 {
                    hasComments = true
                    commentView.dataSource = comments
                }
                updateSubViewContraints(hasComments: hasComments)
                view.setNeedsUpdateConstraints()
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
        
        makeMainViewConstrains()
        
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
        weak var weakSelf = self
        view.actionHandler = {(type:Int) -> Void in
            switch type {
            case 0:
                let chatVC = createChatViewController(withUser: XFUserGlobal.shared.currentUser, goodsInfo: weakSelf?._detailData)
                weakSelf?.navigationController?.pushViewController(chatVC, animated: true)
            case 1:
                MBProgressHUD.showSuccess("已成功加入收藏！")
            case 2:
                MBProgressHUD.showSuccess("已成功加入果篮！")
            case 3:
                MBProgressHUD.showSuccess("将带您结账")
            default:break
            }
        }
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
    
    private func makeMainViewConstrains(){
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
    }
    
    private func updateSubViewContraints(hasComments:Bool) {
        backgroundView.addSubview(headerView)
        backgroundView.addSubview(descriptionView)
        headerView.snp.makeConstraints { (make) in
            make.top.width.equalTo(self.backgroundView)
        }
        if hasComments {
            backgroundView.addSubview(commentView)
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
        } else {
            descriptionView.snp.makeConstraints { (make) in
                make.top.equalTo(self.headerView.snp.bottom).offset(10)
                make.width.bottom.equalTo(self.backgroundView)
            }
            descriptionView.descBackgroundView.snp.makeConstraints { (make) in
                make.height.equalTo(self.backgroundView.snp.height).offset(-42)
            }
        }
    }
    
}

