//
//  XFOrderDetailAddressCell.swift
//  XFruits
//
//  Created by tangkunyin on 2017/8/20.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit

class XFOrderDetailAddressCell: XFAddressItem {

    var dataSource: XFAddress? {
        didSet {
            if let address = dataSource {
                setMyAddress(data: address)
                addressDetailText.textColor = XFConstants.Color.darkGray
            }
        }
    }
    
    override func setUpUI() {
        
        selectionStyle = .none
        
        addSubview(userNameLabel)
        addSubview(mobileLabel)
        addSubview(addressCategoryBtn)
        addSubview(addressDetailText)
        
        userNameLabel.snp.makeConstraints({ (make) in
            make.left.top.equalTo(self).offset(10)
            make.width.equalTo(50)
            make.height.equalTo(20)
        })
        
        addressCategoryBtn.snp.makeConstraints({ (make) in
            make.top.equalTo(userNameLabel.snp.bottom).offset(10)
            make.left.equalTo(userNameLabel.snp.left)
            make.width.lessThanOrEqualTo(50)
            make.height.equalTo(20)
        })
        
        mobileLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(userNameLabel.snp.top)
            make.height.equalTo(20)
            make.left.equalTo(userNameLabel.snp.right).offset(10)
            make.right.equalTo(self).offset(-5)
        })
        
        addressDetailText.snp.makeConstraints({ (make) in
            make.top.equalTo(mobileLabel.snp.bottom).offset(2)
            make.left.equalTo(mobileLabel.snp.left)
            make.right.equalTo(self).offset(-5)
            make.bottom.equalTo(self).offset(-2)
        })
    }

}
