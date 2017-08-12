//
//  XFTPayModeableViewCell.swift
//  XFruits
//
//  Created by zhaojian on 5/28/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class XFTPayModeableViewCell: UITableViewCell {
    
    var data: XFPayChannel? {
        didSet {
            if let data = data,
                let channel = data.channel,
                let name = data.name,
                let isDefault = data.defaultChannel {
                payModeLabel.text = name
                selectedBtn.isSelected = isDefault
                switch channel {
                case 1:
                    payLogoImageView.image = UIImage.imageWithNamed("pay_alipay")
                case 2:
                    payLogoImageView.image = UIImage.imageWithNamed("pay_wxpay")
                default:break
                }
            }
        }
    }

    lazy var payLogoImageView:UIImageView  = {
        let payLogoImageView = UIImageView()
        return payLogoImageView
    }()
    
    lazy var payModeLabel:UILabel = {
        let payModeLabel = UILabel()
        payModeLabel.text = ""
        payModeLabel.textColor = colorWithRGB(102, g: 102, b: 102)
        payModeLabel.font  = UIFont.systemFont(ofSize: 14)
        payModeLabel.textAlignment = NSTextAlignment.center
        return payModeLabel
    }()
    
    
    // 备用，选中支付宝、或微信支付
    lazy var selectedBtn:UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.imageWithNamed("std_icon_checkbox_uncheck"), for: .normal)
        btn.setImage(UIImage.imageWithNamed("std_icon_checkbox_check"), for: .selected)
        return btn
    }()
    
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
        setUpUI()
    }
    
    
    override init(style:UITableViewCellStyle, reuseIdentifier:String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI();
    }
    
    
    func setUpUI() {
        self.addSubview(payLogoImageView)
        self.addSubview(payModeLabel)
        self.addSubview(selectedBtn)
        payLogoImageView.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(30)
            make.centerY.equalTo(self)
        })
        payModeLabel.snp.makeConstraints({ (make) in
            make.left.equalTo(payLogoImageView.snp.right).offset(10)
            make.centerY.equalTo(self)
        })
        selectedBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-30)
            make.centerY.equalTo(self)
            make.size.equalTo(16)
        }
    }
    
}
