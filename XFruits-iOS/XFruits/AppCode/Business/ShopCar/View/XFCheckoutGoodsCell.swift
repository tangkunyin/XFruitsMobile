//
//  XFCheckoutGoodsCell.swift
//  XFruits
//
//  Created by tangkunyin on 2017/7/18.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class XFCheckoutGoodsCell: XFShopCartViewCell {

    var checkoutSource:XFCart? {
        didSet {
            if let item = checkoutSource {
                titleLabel.text = item.name
                quantityLabel.text = "x \(item.quantity ?? 1)"
                descLabel.text = "规格：\(item.desc ?? "其他")"
                priceLabel.text = String(format:"¥ %.2f",item.primePrice!)
                thumbnail.kf.setImage(with: URL.init(string: item.cover!),
                                      placeholder: UIImage.imageWithNamed("Loading-transprent"),
                                      options: [.transition(.fade(0.8))])
            }
        }
    }
    
    override func customInit() {
    
        addSubview(thumbnail)
        addSubview(titleLabel)
        addSubview(quantityLabel)
        addSubview(descLabel)
        addSubview(priceLabel)
        
        quantityLabel.layer.borderWidth = 0
        quantityLabel.layer.borderColor = nil
        
        thumbnail.snp.makeConstraints { (make) in
            make.size.equalTo(90)
            make.top.left.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.thumbnail.snp.right).offset(10)
            make.right.equalTo(self.quantityLabel.snp.left).offset(-10)
            make.height.equalTo(25)
            make.top.equalTo(self.thumbnail.snp.top).offset(5)
            make.bottom.equalTo(self.descLabel.snp.top)
        }
        quantityLabel.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 40, height: 25))
            make.top.equalTo(self.titleLabel.snp.top)
            make.right.equalTo(self).offset(-10)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.thumbnail.snp.right).offset(10)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(20)
            make.top.equalTo(self.titleLabel.snp.bottom)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.thumbnail.snp.right).offset(10)
            make.height.equalTo(25)
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(self.thumbnail.snp.bottom).offset(0)
        }
    }
    

}
