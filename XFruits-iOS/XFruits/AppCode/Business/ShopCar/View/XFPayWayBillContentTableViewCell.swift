//
//  XFPayWayBillContentTableViewCell.swift
//  XFruits
//
//  Created by zhaojian on 5/28/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class XFPayWayBillContentTableViewCell: UITableViewCell {

    
    lazy var leftTip:UILabel = {
        let leftTip = UILabel()
        leftTip.text = "订单编号"
        leftTip.textColor = colorWithRGB(102, g: 102, b: 102)
        leftTip.font  = UIFont.systemFont(ofSize: 14)
        leftTip.textAlignment = NSTextAlignment.center
        return leftTip
    }()
    
    lazy var billContentLabel:UILabel = {
        let billContentLabel = UILabel()
        billContentLabel.text = "$38"
        billContentLabel.textColor = colorWithRGB(102, g: 102, b: 102)
        billContentLabel.font  = UIFont.systemFont(ofSize: 14)
        billContentLabel.textAlignment = NSTextAlignment.center
        return billContentLabel
    }()
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(style:UITableViewCellStyle, reuseIdentifier:String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI();
    }
    
    func  setUpUI() {
        self.addSubview(leftTip)
        leftTip.snp.makeConstraints({ (make) in
//            make.top.equalTo(self.snp.top).offset(11.6)
            make.left.equalTo(self.snp.left).offset(10)
//            make.width.equalTo(50)
            make.centerY.equalTo(self)
        })
        
        
        self.addSubview(billContentLabel)
        billContentLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(self.snp.top).offset(11.6)
            
            make.left.equalTo(leftTip.snp.right).offset(10)
            make.centerY.equalTo(self)
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
