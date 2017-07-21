//
//  XFAddressesManageTableViewCell.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class XFAddressesManageTableViewCell: UITableViewCell {
    
    
    var userNameLabel:UILabel?   // 用户名
    var mobileLabel:UILabel?   // 手机号
    var addressLabel:UILabel?    // 地址详情
    
    var addressCategoryBtn:UIButton?  // 地址类别
    var editAddressBtn:UIButton?  // 编辑按钮
    
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(style:UITableViewCellStyle, reuseIdentifier:String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI();
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func widthForLabel(text:NSString ,font :CGFloat) -> CGFloat {
        let size = text.size(withAttributes:[NSAttributedStringKey.font:sysFontWithSize(font)])
        return size.width
    }
    
    func setMyAddress(address:XFAddress)  {
        
        userNameLabel?.text = address.recipient
        mobileLabel?.text = address.cellPhone
        addressLabel?.text = address.districtCode
        addressCategoryBtn?.setTitle(address.label, for: .normal)
    }
    
    func  setUpUI() {
        
        // 用户名
        userNameLabel = UILabel.init()
//        userNameLabel?.text = "赵小贱"
        userNameLabel?.textColor = XFConstants.Color.darkGray
        userNameLabel?.font  = UIFont.systemFont(ofSize: 14)
        userNameLabel?.numberOfLines = 0
        addSubview(userNameLabel!)
        userNameLabel?.textAlignment = NSTextAlignment.left
        
        userNameLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(snp.top).offset(12)
            make.left.equalTo(snp.left).offset(13)
            
            make.width.equalTo(50)
            make.height.equalTo(17)
        })
        
        // 类别按钮
        addressCategoryBtn = UIButton.init(type: .custom)
        addressCategoryBtn?.setTitle("自己家", for: .normal)
        addressCategoryBtn?.setTitleColor(colorWithRGB(255, g: 105, b: 105), for:.normal)
        addressCategoryBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        addSubview(addressCategoryBtn!)
        addressCategoryBtn?.layer.borderColor = colorWithRGB(255, g: 105, b: 105).cgColor
        addressCategoryBtn?.layer.borderWidth = 1
        let cateTitleText = addressCategoryBtn?.titleLabel?.text
        
        let cateTitleWidth =  widthForLabel(text: cateTitleText! as NSString, font: 10)  + 20
        
        print(cateTitleWidth)
        print(cateTitleWidth / 4)
        addressCategoryBtn?.layer.cornerRadius = cateTitleWidth / 4 > 8 ? 8 :   cateTitleWidth / 4
        addressCategoryBtn?.layer.masksToBounds = true
        
        
        
        addressCategoryBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo((userNameLabel?.snp.bottom)!).offset(5)
            make.left.equalTo(snp.left).offset(13)
            
            make.width.equalTo(cateTitleWidth)
            make.height.equalTo(15)
            
        })
        
        
        // 编辑按钮
        editAddressBtn = UIButton.init(type:.custom)
        editAddressBtn?.setImage(UIImage.imageWithNamed("edit"), for: .normal)
        addSubview(editAddressBtn!)
//        editAddressBtn?.tag = 101
        editAddressBtn?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(snp.right).offset(-20)
            
            make.width.equalTo(20)
            make.height.equalTo(20)
        })
        
        
        // 手机号
        mobileLabel = UILabel.init()
//        mobileLabel?.text = "18658054127"
        mobileLabel?.textColor = XFConstants.Color.darkGray
        mobileLabel?.font  =  UIFont.systemFont(ofSize: 14)
        
        addSubview(mobileLabel!)
        mobileLabel?.textAlignment = NSTextAlignment.left
        
        mobileLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(snp.top).offset(12)
            make.left.equalTo((userNameLabel?.snp.right)!).offset(15)
            make.right.equalTo((editAddressBtn?.snp.left)!).offset(-13)
            
            make.height.equalTo(17)
        })
        
        
        
        // 地址
        addressLabel = UILabel.init()
//        addressLabel?.text = "海淀区农大南路厢黄旗远东青年公寓"
        addressLabel?.textColor = XFConstants.Color.darkGray
        addressLabel?.font  = UIFont.systemFont(ofSize: 12)
        
        addSubview(addressLabel!)
        addressLabel?.textAlignment = NSTextAlignment.left
        addressLabel?.numberOfLines = 0
        addressLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((mobileLabel?.snp.bottom)!).offset(4)
            make.left.equalTo((addressCategoryBtn?.snp.right)!).offset(15)
            make.right.equalTo((editAddressBtn?.snp.left)!).offset(-13)
            
            make.bottom.equalTo(snp.bottom).offset(-6)
            
        })
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

