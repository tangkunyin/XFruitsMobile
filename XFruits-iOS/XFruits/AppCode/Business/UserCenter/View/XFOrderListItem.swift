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

class XFOrderListItem: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        customInit()
    }
    
    var dataSource: XFOrderContent? {
        didSet{
            if let data = dataSource, let covers = data.prodCover {
                titleContainer.text = "订单编号：\(data.orderId)"
                quantityContainer.text = "x\(data.prodCover?.count ?? 0)"
                renderGoodsCover(covers)
                switch data.status {
                case 100:
                    amountContainer.text = "待支付：¥\(data.cashFee)"
                case 500:
                    amountContainer.text = "合计：¥\(data.cashFee)"
                case 600:
                    amountContainer.text = "合计：¥\(data.cashFee)"
                    
                default:
                    break
                }
            }
        }
    }
    
    private func renderGoodsCover(_ covers:Array<String>){
        for (index, item) in covers.enumerated() {
            let cover:UIImageView = UIImageView()
            cover.kf.setImage(with: URL.init(string: item),
                              placeholder: UIImage.imageWithNamed("Loading-squre"),
                              options: [.transition(.fade(1))])
            goodsCoverContainer.addSubview(cover)
            cover.snp.makeConstraints({ (make) in
                make.centerY.equalTo(goodsCoverContainer)
                make.size.equalTo(CGSize(width: 40, height: 40))
                make.left.equalTo(goodsCoverContainer.snp.left).offset(index * 45 +  5)
            })
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
        container.layer.borderWidth = 1
        return container
    }()
    
    lazy var goodsCoverContainer: UIScrollView = {
        let container = UIScrollView()
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
    
    lazy var bottomSeperator: UIView = {
        let view = UIView()
        view.backgroundColor = XFConstants.Color.separatorLine
        return view
    }()
    
    private func customInit(){
        initGoodsContainer()
        initActionContainer()
        contentView.addSubview(titleContainer)
        contentView.addSubview(orderGoodsContainer)
        contentView.addSubview(amountContainer)
        contentView.addSubview(actionContainer)
        contentView.addSubview(bottomSeperator)
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
        bottomSeperator.snp.makeConstraints { (make) in
            make.height.equalTo(10)
            make.left.right.bottom.equalTo(contentView)
        }
    }
    
    private func initGoodsContainer(){
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
    
    private func initActionContainer(){
        
    }

}
