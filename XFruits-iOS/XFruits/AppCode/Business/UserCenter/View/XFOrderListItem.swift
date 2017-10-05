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
        didSet{
            if let data = dataSource, let covers = data.prodCover {
                titleContainer.text = "订单编号：\(data.orderId)"
                quantityContainer.text = "x\(data.prodCover?.count ?? 0)"
                renderGoodsCover(covers)
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
    
    lazy var orderGoodsContainer: UIView = {
        let container = UIView()
        container.layer.borderColor = XFConstants.Color.separatorLine.cgColor
        container.layer.borderWidth = XFConstants.UI.singleLineAdjustOffset
        return container
    }()
    
    lazy var goodsCoverContainer: UIScrollView = {
        let container = UIScrollView()
        container.isUserInteractionEnabled = false
        container.showsHorizontalScrollIndicator = false
        return container
    }()
    
    lazy var quantityContainer: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        return label
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
        initGoodsContainer()
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
            make.height.equalTo(50)
        }
        amountContainer.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 130, height: 40))
            make.left.equalTo(titleContainer).offset(0)
            make.top.equalTo(orderGoodsContainer.snp.bottom).offset(0)
        }
        actionContainer.snp.makeConstraints { (make) in
            make.right.equalTo(titleContainer).offset(0)
            make.top.equalTo(orderGoodsContainer.snp.bottom).offset(0)
            make.left.equalTo(amountContainer.snp.right).offset(5)
            make.height.equalTo(40)
        }
    }
    
    fileprivate func initGoodsContainer(){
        orderGoodsContainer.addSubview(goodsCoverContainer)
        orderGoodsContainer.addSubview(quantityContainer)
        goodsCoverContainer.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.left.top.equalTo(orderGoodsContainer).offset(5)
            make.right.equalTo(quantityContainer.snp.left).offset(-10)
        }
        quantityContainer.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 35, height: 40))
            make.top.equalTo(goodsCoverContainer)
            make.right.equalTo(orderGoodsContainer).offset(-5)
        }
    }
    
    // MARK: - 细节渲染
    fileprivate func renderGoodsCover(_ covers:Array<String>){
        for (index, item) in covers.enumerated() {
            let cover:UIImageView = UIImageView()
            cover.kf.setImage(with: URL.init(string: item),
                              placeholder: UIImage.imageWithNamed("Loading-squre"),
                              options: [.transition(.fade(1))])
            cover.isUserInteractionEnabled = false
            goodsCoverContainer.addSubview(cover)
            cover.snp.makeConstraints({ (make) in
                make.centerY.equalTo(goodsCoverContainer)
                make.size.equalTo(CGSize(width: 40, height: 40))
                make.left.equalTo(goodsCoverContainer.snp.left).offset(index * 50 +  10)
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
