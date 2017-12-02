//
//  XFOrderDetailGoodsCell.swift
//  XFruits
//
//  Created by tangkunyin on 2017/8/20.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit

// 订单详情商品
class XFOrderDetailGoodsCell: XFCheckoutGoodsCell {

    var goodsInfo: XFOrderGoodsItem? {
        didSet {
            if let info = goodsInfo,
                let item = info.product {
                titleLabel.text = item.name
                quantityLabel.text = "x \(item.quantity ?? 1)"
                descLabel.text = "规格：\(item.specification ?? "其他")"
                priceLabel.text = String(format:"¥ %.2f",item.primePrice)
                thumbnail.kf.setImage(with: URL.init(string: item.cover),
                                      placeholder: UIImage.imageWithNamed("Loading-squre-transparent"),
                                      options: [.transition(.fade(0.8))])
            }
        }
    }
    
    override func customInit() {
        super.customInit()
        selectionStyle = .none
    }

}
