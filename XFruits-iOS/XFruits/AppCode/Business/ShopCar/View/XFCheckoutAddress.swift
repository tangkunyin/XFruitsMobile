//
//  XFCheckoutAddress.swift
//  XFruits
//
//  Created by tangkunyin on 2017/7/28.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit


/// 结算页地址信息
class XFCheckoutAddress: UIView {

    var dataSource: XFAddress? {
        didSet {
            if let address = dataSource {
                if let view = self.viewWithTag(99) {
                    view.removeFromSuperview()
                    setMyAddress(data: address)
                }
            }
        }
    }
    
    lazy var noDataTip: UITableViewCell = {
        let tipView = UITableViewCell()
        tipView.tag = 99
        tipView.backgroundColor = UIColor.white
        tipView.textLabel?.font = XFConstants.Font.pfn14
        tipView.textLabel?.textColor = XFConstants.Color.salmon
        tipView.textLabel?.text = "请选择一个有效地址"
        tipView.accessoryType = .disclosureIndicator
        return tipView
    }()
    
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
    lazy var addressLabel:UILabel = {
        let label = UILabel()
        label.font  = XFConstants.Font.pfn12
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
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
        btn.setImage(UIImage.imageWithNamed("right_arrow"), for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
        setUpUI();
    }
    

    func setMyAddress(data:XFAddress)  {
        addressLabel.textColor = data.isDefault == 1 ? XFConstants.Color.salmon : XFConstants.Color.darkGray
        userNameLabel.text = data.recipient
        mobileLabel.text = data.cellPhone
        addressLabel.text = "\(data.districtName)\(data.address)"
        addressCategoryBtn.setTitle(data.label, for: .normal)
    }
    
    func  setUpUI() {
        
        self.backgroundColor = UIColor.white
        self.addSubview(userNameLabel)
        self.addSubview(mobileLabel)
        self.addSubview(editAddressBtn)
        self.addSubview(addressCategoryBtn)
        self.addSubview(addressLabel)
        self.addSubview(noDataTip)
        
        userNameLabel.snp.makeConstraints({ (make) in
            make.left.top.equalTo(self).offset(8)
            make.height.equalTo(20)
            make.right.equalTo(mobileLabel.snp.left).offset(5)
        })
        
        mobileLabel.snp.makeConstraints({ (make) in
            make.size.equalTo(CGSize(width: 110, height: 20))
            make.top.equalTo(userNameLabel.snp.top)
            make.right.equalTo(editAddressBtn.snp.left).offset(-5)
        })
        
        editAddressBtn.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-10)
            make.size.equalTo(CGSize(width: 30, height: 30))
        })
        
        addressCategoryBtn.snp.makeConstraints({ (make) in
            make.left.equalTo(userNameLabel.snp.left)
            make.size.equalTo(CGSize(width: 40, height: 20))
            make.centerY.equalTo(addressLabel)
        })
        
        addressLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(userNameLabel.snp.bottom).offset(5)
            make.left.equalTo(addressCategoryBtn.snp.right).offset(5)
            make.right.equalTo(editAddressBtn.snp.left).offset(-5)
            make.bottom.equalTo(self).offset(-8)
        })
        
        noDataTip.snp.makeConstraints { (make) in
            make.center.size.equalTo(self)
        }
    }
    
}
