//
//  XFCouponItemCellView.swift
//  XFruits
//
//  Created by tangkunyin on 2017/9/20.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit

class XFCouponItemCellView: UITableViewCell {
    
    var dataSource: XFCouponItem? {
        didSet{
            if let couponData = dataSource {
                switch couponData.couponType {
                case 1001:
                    priceLabel.text = String(format:"¥ %.2f",couponData.valueFee)
                    typeLabel.text = "直减劵"
                    titleLabel.text = "满\(couponData.conditionFee)元使用"
                case 1002:
                    priceLabel.text = "\(Int(couponData.valueFee * 10))折"
                    typeLabel.text = "折扣劵"
                    titleLabel.text = "满\(couponData.conditionFee)元可享受\(Int(couponData.valueFee * 10))折优惠"
                case 1003:
                    priceLabel.text = String(format:"¥ %.2f",couponData.valueFee)
                    typeLabel.text = "邮费劵"
                    titleLabel.text = "满\(couponData.conditionFee)元可享受包邮"
                default:
                    priceLabel.text = String(format:"¥ %.2f",couponData.valueFee)
                    typeLabel.text = "其他劵"
                    titleLabel.text = "满\(couponData.conditionFee)元使用"
                }
                dateLabel.text = "有效期: \(stringDateByTimestamp(timeStamp: couponData.expireAt/1000))"
            }
        }
    }

    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.imageWithNamed("coupon_bg_coupon_overdue"))
        imageView.layer.masksToBounds = false
        return imageView
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = XFConstants.Font.pfn12
        label.textColor = XFConstants.Color.salmon
        label.textAlignment = .left
        return label
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.purpleyGrey
        label.textAlignment = .left
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = XFConstants.Font.pfn16
        label.textColor = XFConstants.Color.purpleyGrey
        label.textAlignment = .left
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.purpleyGrey
        label.textAlignment = .left
        return label
    }()
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
        self.setUpUI();
    }
    
    override init(style:UITableViewCellStyle, reuseIdentifier:String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI();
    }
    
    fileprivate func setUpUI() {
        selectionStyle = .none
        contentView.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView).inset(UIEdgeInsetsMake(5, 5, 5, 5))
        }
        backgroundImageView.addSubview(priceLabel)
        backgroundImageView.addSubview(typeLabel)
        backgroundImageView.addSubview(titleLabel)
        backgroundImageView.addSubview(dateLabel)
        
        priceLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(backgroundImageView).offset(10)
            make.size.equalTo(CGSize(width: 80, height: 30))
        }
        typeLabel.snp.makeConstraints { (make) in
            make.left.size.equalTo(priceLabel)
            make.top.equalTo(priceLabel.snp.bottom).offset(8)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(backgroundImageView).offset(10)
            make.left.equalTo(priceLabel.snp.right).offset(10)
            make.right.equalTo(backgroundImageView).offset(-10)
            make.height.equalTo(30)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
    }

}
