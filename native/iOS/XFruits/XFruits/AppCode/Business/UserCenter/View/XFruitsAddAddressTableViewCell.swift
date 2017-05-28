//
//  XFruitsAddAddressTableViewCell.swift
//  XFruits
//
//  Created by zhaojian on 5/18/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class XFruitsAddAddressTableViewCell: UITableViewCell {
    
    
    var leftTipLabel:UILabel?
    var inputContentTextFiled:UITextField?
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(style:UITableViewCellStyle, reuseIdentifier:String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI();
    }
    
    
    
    func  setUpUI() {
        // 用户名
        leftTipLabel = UILabel.init()
//        leftTipLabel?.text = "收货人"
        leftTipLabel?.textColor = colorWithRGB(153, g: 153, b: 153)
        leftTipLabel?.font  = UIFont.systemFont(ofSize: 16)
        
        addSubview(self.leftTipLabel!)
        leftTipLabel?.textAlignment = NSTextAlignment.left
        
        leftTipLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.snp.top).offset(12)
            make.left.equalTo(self.snp.left).offset(13)
            
            make.width.equalTo(70)
            make.height.equalTo(19)
        })
        
        
        inputContentTextFiled = UITextField.init()
//        self.inputContentTextFiled?.text = "测试"
        addSubview(self.inputContentTextFiled!)

        inputContentTextFiled?.textColor  = colorWithRGB(102, g: 102, b: 102)
        inputContentTextFiled?.font = UIFont.systemFont(ofSize: 16)
        inputContentTextFiled?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.snp.top).offset(12)
            make.left.equalTo((self.leftTipLabel?.snp.right)!).offset(13)
            make.right.equalTo(self.snp.right).offset(-13)
            make.bottom.equalTo(self.snp.bottom).offset(-12)

        })
        
        
            
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
