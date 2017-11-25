//
//  XFDetailViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit

class XFDetailViewController: XFBaseSubViewController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeMainViewConstrains()
        
        weak var weakSelf = self
        if let prodId = prodId {
            XFProductService.getProductDetail(pid: prodId, { (data) in
                if let detailData = data as? ProductDetail {
                    weakSelf?._detailData = detailData
                }
            })
        }
    }
    
    // MARK: - fileprivate and lazy variables
    fileprivate lazy var contentView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.backgroundColor = XFConstants.Color.commonBackground
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    fileprivate lazy var actionBarView: XFDetailActionBarView = {
        let view = XFDetailActionBarView()
        weak var weakSelf = self
        view.actionHandler = {(type:Int) -> Void in
            switch type {
            case 0:
                weakSelf?.showChatViewController()
            case 1:
                weakSelf?.addCollection()
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
    
    
    fileprivate func addCollection(){
        weak var weakSelf = self
        let param:[String:String]  =  ["productId":prodId!]
        XFCollectionService.addCollection(params:param ) { (success) in
            if success as! Bool {
                weakSelf?.showSuccess("已成功加入收藏")
            } else {
                weakSelf?.showError("收藏失败，可能已经收藏过了奥~")
            }
        }
    }
    
    fileprivate func showChatViewController () {
        if let product = _detailData,
            let sessionController = createChatViewController(title: "商品详情", product: product) { 
            navigationController?.pushViewController(sessionController, animated: true)
        }
    }
    
    fileprivate func addToShopCart(checkoutNow: Bool) {
        if let detailData: ProductDetail = _detailData {
            let item: ProductItem = detailData.convertToProductItem()
            let result = XFCartUtils.sharedInstance.addItem(item: item)
            if result {
                if checkoutNow {
                    goToCheckout(item: item)
                } else {
                    showSuccess("成功添加到果篮")
                }
            } else {
                showError("操作失败，请稍后尝试~")
            }
        }
    }
    
    fileprivate func goToCheckout(item: ProductItem) {
        if XFUserGlobal.shared.isLogin {
            if XFCartUtils.sharedInstance.selectItem(gid: item.id, checked: true)
                && XFCartUtils.sharedInstance.getAll().count > 0 {
                let checkoutVC = XFCheckoutViewController()
                checkoutVC.totalGoodsAmount = item.primePrice
                navigationController?.pushViewController(checkoutVC, animated: true)
            }
        } else {
            showError("请先登录后再购买")
        }
    }
    
    /// 轮播及商品信息
    fileprivate lazy var headerView: XFDetailHeaderView = {
        let view = XFDetailHeaderView()
        return view
    }()
    
    /// 评论
    fileprivate lazy var commentView: XFDetailCommentView = {
        let view = XFDetailCommentView()
        return view
    }()
    
    /// 详情图展
    fileprivate lazy var descriptionView: XFDetailDescriptionView = {
        let view = XFDetailDescriptionView()
        return view
    }()
    
    fileprivate func makeMainViewConstrains(){
        view.addSubview(contentView)
        view.addSubview(actionBarView)
        contentView.snp.makeConstraints { (make) in
            make.width.top.equalTo(view)
        }
        actionBarView.snp.makeConstraints { (make) in
            make.height.equalTo(45)
            make.width.equalTo(view)
            make.top.equalTo(self.contentView.snp.bottom)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.width.bottom.equalTo(view)
            }
        }
    }
    
    fileprivate func updateSubViewContraints(hasComments:Bool) {
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

