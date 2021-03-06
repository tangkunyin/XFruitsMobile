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

class XFOrderTitleItemCell: UITableViewCell {
    
    var dataSource: XFOrderContent? {
        didSet {
            if let data = dataSource {
                titleContainer.text = "订单编号：\(data.orderId)"
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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        customInit()
    }
    
    private func customInit() {
        contentView.addSubview(titleContainer)
        titleContainer.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView).inset(UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10))
        }
    }
}

// 订单列表商品
class XFOrderGoodsItemCell: XFCheckoutGoodsCell {
    var goodsInfo: XFOrderProduct? {
        didSet {
            if let item = goodsInfo {
                titleLabel.text = item.name
                quantityLabel.text = "x \(item.buyCount)"
                descLabel.text = "规格：\(item.specification)"
                priceLabel.text = String(format:"¥ %.2f",item.primePrice)
                thumbnail.kf.setImage(with: URL.init(string: item.cover),
                                      placeholder: UIImage.imageWithNamed("Loading-squre-transparent"),
                                      options: [.transition(.fade(1.0))])
            }
        }
    }
    override func customInit() {
        super.customInit()
        selectionStyle = .none
    }
}

class XFOrderBarItemCell: UITableViewCell {
    
    var onBarBtnClick: ((Int,XFOrderContent)->Void)?
    
    var dataSource: XFOrderContent? {
        didSet {
            if let data = dataSource {
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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        customInit()
    }
    
    private func customInit() {
        contentView.addSubview(amountContainer)
        contentView.addSubview(actionContainer)
        amountContainer.snp.makeConstraints { (make) in
            make.width.equalTo(130)
            make.left.equalTo(contentView).offset(10)
            make.top.bottom.equalTo(contentView)
        }
        actionContainer.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-10)
            make.left.equalTo(amountContainer.snp.right).offset(5)
            make.top.bottom.equalTo(contentView)
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
