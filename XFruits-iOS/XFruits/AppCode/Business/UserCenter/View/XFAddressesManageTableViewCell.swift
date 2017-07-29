//
//  XFAddressesManageTableViewCell.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class XFAddressesManageTableViewCell: UITableViewCell {
    
    // 用户名
    lazy var userNameLabel:UILabel = {
        let label = UILabel()
        label.textColor = XFConstants.Color.darkGray
        label.font  = XFConstants.Font.mainMenuFont
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    
    // 手机号
    lazy var mobileLabel:UILabel = {
        let label = UILabel()
        label.textColor = XFConstants.Color.darkGray
        label.font  =  XFConstants.Font.mainMenuFont
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    
    // 地址详情
    lazy var addressLabel:UILabel = {
        let label = UILabel()
        label.textColor = XFConstants.Color.darkGray
        label.font  = XFConstants.Font.mainBodyFont
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    // 地址类别
    lazy var addressCategoryBtn:UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("自己家", for: .normal)
        btn.setTitleColor(colorWithRGB(255, g: 105, b: 105), for:.normal)
        btn.titleLabel?.font = XFConstants.Font.bottomMenuFont
        btn.layer.borderColor = colorWithRGB(255, g: 105, b: 105).cgColor
        btn.layer.borderWidth = 1
        btn.layer.masksToBounds = true
        btn.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        btn.layer.cornerRadius = 10
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
    
    func setMyAddress(address:XFAddress)  {
        userNameLabel.text = address.recipient
        mobileLabel.text = address.cellPhone
        addressLabel.text = address.districtCode
        addressCategoryBtn.setTitle(address.label, for: .normal)
    }
    
    func  setUpUI() {
        addSubview(editAddressBtn)
        addSubview(userNameLabel)
        addSubview(mobileLabel)
        addSubview(addressCategoryBtn)
        addSubview(addressLabel)
        
        editAddressBtn.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-10)
            make.size.equalTo(CGSize(width: 30, height: 30))
        })
        userNameLabel.snp.makeConstraints({ (make) in
//            make.size.equalTo(CGSize(width: 60, height: 20))
            make.left.top.equalTo(self).offset(10)
            make.width.lessThanOrEqualTo(60)
            make.height.equalTo(20)


//            make.right.equalTo(mobileLabel.snp.left)
        })
        
        
        addressCategoryBtn.snp.makeConstraints({ (make) in
            make.top.equalTo(userNameLabel.snp.bottom).offset(10)
            make.left.equalTo(userNameLabel.snp.left)
            make.width.lessThanOrEqualTo(120)
            make.height.equalTo(20)
        })
        
        mobileLabel.snp.makeConstraints({ (make) in
            //            make.size.equalTo(CGSize(width: 110, height: 20))
            make.top.equalTo(userNameLabel.snp.top)
            make.left.equalTo(userNameLabel.snp.right)
            make.right.equalTo(editAddressBtn.snp.left).offset(-5)
        })
        
        addressLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(addressCategoryBtn.snp.top)
            make.left.equalTo(mobileLabel.snp.left)
            make.right.equalTo(editAddressBtn.snp.left).offset(-5)
            make.bottom.equalTo(self).offset(-5)
        })
        
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

