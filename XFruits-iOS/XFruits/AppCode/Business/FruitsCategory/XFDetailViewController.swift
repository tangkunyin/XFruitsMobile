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


class XFDetailViewController: XFBaseSubViewController,UIScrollViewDelegate {
    
    var prodId:String?
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
    
    deinit {
        dPrint("XFDetailViewController deinit...")
    }
    
    lazy var request:XFCommonService = {
        let serviceRequest = XFCommonService()
        return serviceRequest
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 处理版本差异
        if #available(iOS 11.0, *) {
            contentView.contentInsetAdjustmentBehavior = .never
        } else {
            // 此设置仅对iOS11以前版本有效
            automaticallyAdjustsScrollViewInsets = true
        }
        
        self.clearNavigationBar = true
        // 设置详情页专属返回按钮
        self.backButtonImages = [XFBackButtonImages.normal: "detail_BackHighlight",
                                 XFBackButtonImages.highlighted: "detail_BackNormal"]
        
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
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let minAlphaOffset:CGFloat = 0
        let maxAlphaOffset:CGFloat = 220
        let offset:CGFloat = scrollView.contentOffset.y
        let alpha:CGFloat = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset)
        navBarBackgroundView?.alpha = alpha
    }
    
    // MARK: - private and lazy variables
    private lazy var contentView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.delegate = self
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
                MBProgressHUD.showSuccess("已成功加入收藏")
            case 2:
                weakSelf?.addToShopCart(checkoutNow: false)
            case 3:
                weakSelf?.addToShopCart(checkoutNow: true)
            default:
                break
            }
        }
        return view
    }()
    
    private func addToShopCart(checkoutNow: Bool) {
        if let detailData: ProductDetail = _detailData {
            let item: ProductItem = detailData.convertToProductItem()
            let result = XFCartUtils.sharedInstance.addItem(item: item)
            if result {
                if checkoutNow {
                    goToCheckout(item: item)
                } else {
                    MBProgressHUD.showSuccess("成功添加到果篮")
                }
            } else {
                MBProgressHUD.showError("操作失败，请稍后尝试~")
            }
        }
    }
    
    private func goToCheckout(item: ProductItem) {
        if XFUserGlobal.shared.isLogin {
            if XFCartUtils.sharedInstance.selectItem(gid: item.id, checked: true)
                && XFCartUtils.sharedInstance.getAll().count > 0 {
                let checkoutVC = XFCheckoutViewController()
                checkoutVC.totalGoodsAmount = item.primePrice
                navigationController?.pushViewController(checkoutVC, animated: true)
            }
        } else {
            MBProgressHUD.showError("请先登录后再购买")
        }
    }
    
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
        view.addSubview(contentView)
        view.addSubview(actionBarView)
        contentView.snp.makeConstraints { (make) in
            make.width.top.equalTo(self.view)
        }
        actionBarView.snp.makeConstraints { (make) in
            make.height.equalTo(45)
            make.top.equalTo(self.contentView.snp.bottom)
            make.width.bottom.equalTo(self.view)
        }
    }
    
    private func updateSubViewContraints(hasComments:Bool) {
        contentView.addSubview(headerView)
        contentView.addSubview(descriptionView)
        headerView.snp.makeConstraints { (make) in
            make.top.width.equalTo(self.contentView)
        }
        if hasComments {
            contentView.addSubview(commentView)
            commentView.snp.makeConstraints { (make) in
                make.width.equalTo(self.contentView)
                make.top.equalTo(self.headerView.snp.bottom).offset(10)
            }
            descriptionView.snp.makeConstraints { (make) in
                make.top.equalTo(self.commentView.snp.bottom).offset(10)
                make.width.bottom.equalTo(self.contentView)
            }
            descriptionView.descBackgroundView.snp.makeConstraints { (make) in
                make.height.equalTo(self.contentView.snp.height).offset(-42)
            }
        } else {
            descriptionView.snp.makeConstraints { (make) in
                make.top.equalTo(self.headerView.snp.bottom).offset(10)
                make.width.bottom.equalTo(self.contentView)
            }
            descriptionView.descBackgroundView.snp.makeConstraints { (make) in
                make.height.equalTo(self.contentView.snp.height).offset(-42)
            }
        }
    }
}

