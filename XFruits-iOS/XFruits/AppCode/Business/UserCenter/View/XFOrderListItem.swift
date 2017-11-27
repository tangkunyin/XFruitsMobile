//
//  XFOrderListItem.swift
//  XFruits
//
//  Created by tangkunyin on 2017/8/20.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher


enum XFOrderItemBarType: Int {
    case payBar = 0
    case queryExpressBar = 1
    case deliverConfirmBar = 2
    case evaluateBar = 3
}

class XFOrderListItem: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        customInit()
    }
    
    var onBarBtnClick: ((Int,XFOrderContent)->Void)?
    
    var dataSource: XFOrderContent? {
        didSet {
            if let data = dataSource, let products = data.productList {
                titleContainer.text = "订单编号：\(data.orderId)"
                renderGoodsInfo(products)
                switch data.status {
                // 待支付
                case 100:
                    amountContainer.text = "待支付：¥\(data.cashFee)"
                    renderPayActionBar()
                // 查询物流、确认收货
                case 500:
                    amountContainer.text = "合计：¥\(data.cashFee)"
                    renderDeliveredActionBar()
                // 待评价
                case 600:
                    amountContainer.text = "合计：¥\(data.cashFee)"
                    renderEvaluateActionBar()
                default:
                    amountContainer.text = "合计：¥\(data.cashFee)"
                    break
                }
            }
        }
    }
    
    lazy var titleContainer: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        return label
    }()
    
    lazy var orderGoodsContainer: UIScrollView = {
        let container = UIScrollView()
        container.isUserInteractionEnabled = false
        container.showsHorizontalScrollIndicator = false
        container.showsVerticalScrollIndicator = false
        container.isPagingEnabled = true
        return container
    }()
    
    lazy var amountContainer: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        return label
    }()
    
    lazy var actionContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    fileprivate func customInit(){
        selectionStyle = .none
        contentView.addSubview(titleContainer)
        contentView.addSubview(orderGoodsContainer)
        contentView.addSubview(amountContainer)
        contentView.addSubview(actionContainer)
        titleContainer.snp.makeConstraints { (make) in
            make.left.top.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.height.equalTo(30)
        }
        orderGoodsContainer.snp.makeConstraints { (make) in
            make.left.right.equalTo(contentView)
            make.top.equalTo(titleContainer.snp.bottom).offset(0)
            make.height.equalTo(110)
        }
        amountContainer.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 130, height: 30))
            make.left.equalTo(titleContainer).offset(0)
            make.top.equalTo(orderGoodsContainer.snp.bottom).offset(10)
        }
        actionContainer.snp.makeConstraints { (make) in
            make.right.equalTo(titleContainer).offset(0)
            make.top.equalTo(orderGoodsContainer.snp.bottom).offset(5)
            make.left.equalTo(amountContainer.snp.right).offset(5)
            make.height.equalTo(40)
        }
    }
    
    // MARK: - 细节渲染
    fileprivate func renderGoodsInfo(_ products:Array<XFOrderProduct>) {
        // 先清空在渲染
        for view: UIView in orderGoodsContainer.subviews {
            view.removeFromSuperview()
        }
        for (index, item) in products.enumerated() {
            let productInfo = XFOrderGoodsItemCell()
            productInfo.goodsInfo = item
            orderGoodsContainer.addSubview(productInfo)
            productInfo.snp.makeConstraints({ (make) in
                make.top.size.equalTo(orderGoodsContainer)
                if index == 0 {
                    make.left.equalTo(orderGoodsContainer)
                } else if let previousView = orderGoodsContainer.subviews[index-1] as? XFOrderGoodsItemCell {
                    make.left.equalTo(previousView.snp.right).offset(0)
                }
                if index == products.count - 1 {
                    make.right.equalTo(orderGoodsContainer)
                }
            })
        }
    }
    
    fileprivate func renderPayActionBar(){
        let payBtn = createActionBtn(title: "去支付",
                                     titleColor: UIColor.white,
                                     borderColor: XFConstants.Color.salmon,
                                     backgroundColor: XFConstants.Color.salmon,
                                     tag: .payBar)
        actionContainer.addSubview(payBtn)
        payBtn.snp.makeConstraints { (make) in
            make.right.centerY.equalTo(actionContainer)
            make.size.equalTo(CGSize.init(width: 80, height: 30))
        }
    }
    
    fileprivate func renderDeliveredActionBar(){
        let expressQueryBtn = createActionBtn(title: "查询物流",
                                              titleColor: XFConstants.Color.darkGray,
                                              borderColor: XFConstants.Color.darkGray,
                                              backgroundColor: UIColor.white,
                                              tag: .queryExpressBar)
        let deliverConfirmBtn = createActionBtn(title: "确认收货",
                                                titleColor: XFConstants.Color.salmon,
                                                borderColor: XFConstants.Color.salmon,
                                                backgroundColor: UIColor.white,
                                                tag: .deliverConfirmBar)
        actionContainer.addSubview(expressQueryBtn)
        actionContainer.addSubview(deliverConfirmBtn)
        expressQueryBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(actionContainer)
            make.size.equalTo(CGSize.init(width: 80, height: 30))
            make.right.equalTo(deliverConfirmBtn.snp.left).offset(-15)
        }
        deliverConfirmBtn.snp.makeConstraints { (make) in
            make.right.centerY.equalTo(actionContainer)
            make.size.equalTo(CGSize.init(width: 80, height: 30))
        }
    }
    
    fileprivate func renderEvaluateActionBar(){
        let commentBtn = createActionBtn(title: "去评价",
                                         titleColor: UIColor.white,
                                         borderColor: XFConstants.Color.salmon,
                                         backgroundColor: XFConstants.Color.salmon,
                                         tag: .evaluateBar)
        actionContainer.addSubview(commentBtn)
        commentBtn.snp.makeConstraints { (make) in
            make.right.centerY.equalTo(actionContainer)
            make.size.equalTo(CGSize.init(width: 80, height: 30))
        }
    }
    
    fileprivate func createActionBtn(title:String,
                                 titleColor:UIColor,
                                 borderColor:UIColor,
                                 backgroundColor:UIColor,
                                 tag:XFOrderItemBarType) -> UIButton {
        let btn = UIButton.init(type: .custom)
        btn.tag = tag.rawValue
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(titleColor, for: .normal)
        btn.titleLabel?.font = XFConstants.Font.pfn14
        btn.backgroundColor = backgroundColor
        btn.layer.borderWidth = XFConstants.UI.singleLineAdjustOffset
        btn.layer.borderColor = borderColor.cgColor
        btn.layer.cornerRadius = 5
        btn.addTarget(self, action: #selector(onBarButtonClicked(_:)), for: .touchUpInside)
        return btn
    }
    
    @objc fileprivate func onBarButtonClicked(_ btn: UIButton) {
        if let completion = onBarBtnClick, let data = dataSource {
            completion(btn.tag, data)
        }
    }
    
}
