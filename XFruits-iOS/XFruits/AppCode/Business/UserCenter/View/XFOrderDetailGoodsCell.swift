//
//  XFOrderDetailGoodsCell.swift
//  XFruits
//
//  Created by tangkunyin on 2017/8/20.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit

// 订单列表商品
class XFOrderGoodsView: UIView {
    
    lazy var thumbnail:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var titleLabel:UILabel = {
        let title = UILabel()
        title.textColor = XFConstants.Color.darkGray
        title.font = XFConstants.Font.pfn14
        title.textAlignment = .left
        title.numberOfLines = 1
        title.adjustsFontSizeToFitWidth = true
        title.lineBreakMode = .byTruncatingTail
        return title
    }()
    
    lazy var descLabel:UILabel = {
        let title = UILabel()
        title.textColor = XFConstants.Color.darkGray
        title.font = XFConstants.Font.pfn14
        title.textAlignment = .left
        title.numberOfLines = 2
        title.adjustsFontSizeToFitWidth = false
        title.lineBreakMode = .byTruncatingTail
        return title
    }()
    
    lazy var priceLabel:UILabel = {
        let title = UILabel()
        title.textColor = XFConstants.Color.darkGray
        title.font = XFConstants.Font.pfn14
        title.textAlignment = .left
        title.numberOfLines = 2
        title.adjustsFontSizeToFitWidth = false
        title.lineBreakMode = .byTruncatingTail
        return title
    }()
    
    lazy var quantityLabel:UILabel = {
        let title = UILabel()
        title.textColor = XFConstants.Color.darkGray
        title.font = XFConstants.Font.pfn14
        title.textAlignment = .center
        title.numberOfLines = 1
        title.adjustsFontSizeToFitWidth = false
        title.layer.borderWidth = XFConstants.UI.singleLineAdjustOffset
        title.layer.borderColor = XFConstants.Color.darkGray.cgColor
        title.text = "0"
        return title
    }()
    
    
    var goodsInfo: XFOrderProduct? {
        didSet {
            if let item = goodsInfo {
                titleLabel.text = item.name
                quantityLabel.text = "x \(item.buyCount)"
                descLabel.text = "规格：\(item.specification)"
                priceLabel.text = String(format:"¥ %.2f",item.primePrice)
                thumbnail.kf.setImage(with: URL.init(string: item.cover),
                                      placeholder: UIImage.imageWithNamed("Loading-transprent"),
                                      options: [.transition(.fade(1.0))])
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    private func customInit() {
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
                                      placeholder: UIImage.imageWithNamed("Loading-transprent"),
                                      options: [.transition(.fade(0.8))])
            }
        }
    }
    
    override func customInit() {
        super.customInit()
        selectionStyle = .none
    }

}
