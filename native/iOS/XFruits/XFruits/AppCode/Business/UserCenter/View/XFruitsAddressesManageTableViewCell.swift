//
//  XFruitsAddressesManageTableViewCell.swift
//  XFruits
//
//  Created by zhaojian on 5/16/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class XFruitsAddressesManageTableViewCell: UITableViewCell {

    
    var userNameLabel:UILabel?
    var mobileLabel:UILabel?
    var addressLabel:UILabel?

    var addressCategoryBtn:UIButton?
    var editAddressBtn:UIButton?


    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(style:UITableViewCellStyle, reuseIdentifier:String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI();
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    func  setUpUI() {
        
        // 用户名
        self.userNameLabel = UILabel.init()
        self.userNameLabel?.text = "姜小码"
        self.userNameLabel?.textColor = colorWithRGB(102, g: 102, b: 102)
        self.userNameLabel?.font  = UIFont.systemFont(ofSize: 14)
        self.userNameLabel?.numberOfLines = 0
        self.addSubview(self.userNameLabel!)
        self.userNameLabel?.textAlignment = NSTextAlignment.left

        self.userNameLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.snp.top).offset(12)
            make.left.equalTo(self.snp.left).offset(13)
            
            make.width.equalTo(50)
            make.height.equalTo(17)
        })
        
        // 类别按钮
        self.addressCategoryBtn = UIButton.init(type: .custom)
        self.addressCategoryBtn?.setTitle("家", for: .normal)
        self.addressCategoryBtn?.setTitleColor(colorWithRGB(255, g: 105, b: 105), for:.normal)
        self.addressCategoryBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        self.addSubview(self.addressCategoryBtn!)
        self.addressCategoryBtn?.layer.borderColor = colorWithRGB(255, g: 105, b: 105).cgColor
        self.addressCategoryBtn?.layer.borderWidth = 1
        
        self.addressCategoryBtn?.layer.cornerRadius = 8
        self.addressCategoryBtn?.layer.masksToBounds = true
        self.addressCategoryBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.userNameLabel?.snp.bottom)!).offset(5)
            make.left.equalTo(self.snp.left).offset(13)
            
            make.width.equalTo(50)
            make.height.equalTo(15)
//            make.bottom.equalTo(self.snp.bottom).offset(-6)

        })
 
     
        // 编辑按钮
        self.editAddressBtn = UIButton.init(type:.custom)
        self.editAddressBtn?.setImage(UIImage.imageWithNamed("myScore"), for: .normal)
        self.addSubview(self.editAddressBtn!)
        
        self.editAddressBtn?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self.snp.right).offset(-20)
            
            make.width.equalTo(20)
            make.height.equalTo(20)
        })
       
        
        // 手机号
        self.mobileLabel = UILabel.init()
        self.mobileLabel?.text = "18658054127"
        self.mobileLabel?.textColor = colorWithRGB(102, g: 102, b: 102)
        self.mobileLabel?.font  = UIFont.systemFont(ofSize: 14)
        
        self.addSubview(self.mobileLabel!)
        self.mobileLabel?.textAlignment = NSTextAlignment.left
        
        self.mobileLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.snp.top).offset(12)
            make.left.equalTo((self.userNameLabel?.snp.right)!).offset(13)
            make.right.equalTo((self.editAddressBtn?.snp.left)!).offset(-13)
            
            make.height.equalTo(17)
        })
        
    
         
         // 地址
         self.addressLabel = UILabel.init()
         self.addressLabel?.text = "海淀区农大南路厢黄旗远东青年公寓393"
         self.addressLabel?.textColor = colorWithRGB(102, g: 102, b: 102)
         self.addressLabel?.font  = UIFont.systemFont(ofSize: 12)
 
         self.addSubview(self.addressLabel!)
         self.addressLabel?.textAlignment = NSTextAlignment.left
         self.addressLabel?.numberOfLines = 0
         self.addressLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.mobileLabel?.snp.bottom)!).offset(4)
            make.left.equalTo((self.addressCategoryBtn?.snp.right)!).offset(13)
            make.right.equalTo((self.editAddressBtn?.snp.left)!).offset(-13)
         
            make.bottom.equalTo(self.snp.bottom).offset(-6)

          })

     

        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
