//
//  XFPayWayBillInfoTableViewCell.swift
//  XFruits
//
//  Created by zhaojian on 5/28/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class XFPayWayBillInfoTableViewCell: UITableViewCell {

    lazy var waitPayTip:UILabel = {
        let waitPayTip = UILabel()
        waitPayTip.text = "已下单，您需要继续完成支付！"
        waitPayTip.textColor = colorWithRGB(102, g: 102, b: 102)
        waitPayTip.font  = UIFont.systemFont(ofSize: 14)
        waitPayTip.textAlignment = NSTextAlignment.center
        return waitPayTip
    }()
    
    lazy var remainTimeLabel:UILabel = {
        let remainTimeLabel = UILabel()
        remainTimeLabel.text = "58 : 54"
        remainTimeLabel.textColor = colorWithRGB(102, g: 102, b: 102)
        remainTimeLabel.font  = UIFont.systemFont(ofSize: 48)
        remainTimeLabel.textAlignment = NSTextAlignment.center
        return remainTimeLabel
    }()
    
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(style:UITableViewCellStyle, reuseIdentifier:String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI();
    }
    
    func  setUpUI() {
        self.addSubview(waitPayTip)
        waitPayTip.snp.makeConstraints({ (make) in
            make.top.equalTo(self.snp.top).offset(32)

             make.height.equalTo(14)
            make.centerX.equalTo(self)
        })
        
        
        self.addSubview(remainTimeLabel)
        remainTimeLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(waitPayTip.snp.bottom).offset(32)
            
            make.height.equalTo(48)
            make.centerX.equalTo(self)
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
