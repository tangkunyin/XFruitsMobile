//
//  XFAddressItem.swift
//  XFruits
//
//  Created by tangkunyin on 2017/11/11.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit

class XFAddressItem: UITableViewCell {

    // 用户名
    lazy var userNameLabel:UILabel = {
        let label = UILabel()
        label.font  = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    
    // 手机号
    lazy var mobileLabel:UILabel = {
        let label = UILabel()
        label.font  =  XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        label.textAlignment = NSTextAlignment.right
        return label
    }()
    
    // 地址详情
    lazy var addressDetailText:UILabel = {
        let label = UILabel()
        label.font  = XFConstants.Font.pfn12
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    // 地址类别
    lazy var addressDefaultTag:UILabel = {
        let label = UILabel()
        label.text = "默认"
        label.isHidden = true
        label.font = XFConstants.Font.pfn10
        label.textColor = XFConstants.Color.white
        label.textAlignment = .center
        label.backgroundColor = XFConstants.Color.lightishGreen
        return label
    }()
    
    // 地址类别
    lazy var addressCategoryBtn:UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.titleLabel?.font = XFConstants.Font.pfn12
        btn.setTitleColor(colorWithRGB(255, g: 105, b: 105), for:.normal)
        btn.layer.borderColor = colorWithRGB(255, g: 105, b: 105).cgColor
        btn.layer.borderWidth = 1
        btn.layer.masksToBounds = true
        btn.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    // 编辑按钮
    lazy var editAddressBtn:UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.imageWithNamed("edit"), for: .normal)
        return btn
    }()
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
        setUpUI();
    }
    
    override init(style:UITableViewCellStyle, reuseIdentifier:String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI();
    }
    
    func setMyAddress(data:XFAddress)  {
        addressDefaultTag.isHidden = data.isDefault == 1 ? false : true
        userNameLabel.text = data.recipient
        mobileLabel.text = data.cellPhone
        addressDetailText.text = "\(data.districtName)\(data.address)"
        addressCategoryBtn.setTitle(data.label, for: .normal)
    }
    
    func  setUpUI() {
        
        contentView.addSubview(userNameLabel)
        contentView.addSubview(mobileLabel)
        contentView.addSubview(editAddressBtn)
        contentView.addSubview(addressDefaultTag)
        contentView.addSubview(addressCategoryBtn)
        contentView.addSubview(addressDetailText)
        
        userNameLabel.snp.makeConstraints({ (make) in
            make.left.top.equalTo(contentView).offset(8)
            make.height.equalTo(20)
            make.right.equalTo(mobileLabel.snp.left).offset(5)
        })
        
        mobileLabel.snp.makeConstraints({ (make) in
            make.size.equalTo(CGSize.init(width: 110, height: 20))
            make.top.equalTo(userNameLabel.snp.top)
            make.right.equalTo(editAddressBtn.snp.left).offset(-5)
        })
        
        editAddressBtn.snp.makeConstraints({ (make) in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-10)
            make.size.equalTo(CGSize(width: 30, height: 30))
        })
        
        addressDefaultTag.snp.makeConstraints { (make) in
            make.top.equalTo(userNameLabel.snp.bottom).offset(2)
            make.size.equalTo(CGSize(width: 30, height: 16))
            make.centerX.equalTo(addressCategoryBtn)
        }
        
        addressCategoryBtn.snp.makeConstraints({ (make) in
            make.left.equalTo(userNameLabel.snp.left)
            make.height.equalTo(20)
            make.width.greaterThanOrEqualTo(40)
            make.width.lessThanOrEqualTo(100)
            make.centerY.equalTo(addressDetailText)
        })
        
        addressDetailText.snp.makeConstraints({ (make) in
            make.height.equalTo(50.5)
            make.top.equalTo(userNameLabel.snp.bottom).offset(5)
            make.left.equalTo(addressCategoryBtn.snp.right).offset(5)
            make.right.equalTo(editAddressBtn.snp.left).offset(-5)
        })
        
    }

}
