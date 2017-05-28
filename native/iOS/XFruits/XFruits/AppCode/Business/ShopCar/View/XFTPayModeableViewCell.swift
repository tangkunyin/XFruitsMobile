//
//  XFTPayModeableViewCell.swift
//  XFruits
//
//  Created by zhaojian on 5/28/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class XFTPayModeableViewCell: UITableViewCell {

    lazy var payLogoImageView:UIImageView  = {
       let payLogoImageView = UIImageView()
        payLogoImageView.image = UIImage.imageWithNamed("apple")
        return payLogoImageView
    }()
    
    lazy var payModeLabel:UILabel = {
        let payModeLabel = UILabel()
        payModeLabel.text = "支付宝支付"
        payModeLabel.textColor = colorWithRGB(102, g: 102, b: 102)
        payModeLabel.font  = UIFont.systemFont(ofSize: 14)
        payModeLabel.textAlignment = NSTextAlignment.center
        return payModeLabel
    }()
    
    
    // 备用，选中支付宝、或微信支付
    lazy var selectedBtn:UIButton = {
        let  selectedBtn = UIButton.init()
        selectedBtn.setImage(UIImage.imageWithNamed(""), for: .normal)
        return selectedBtn
    }()
    
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(style:UITableViewCellStyle, reuseIdentifier:String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI();
    }
    
    func  setUpUI() {
        self.addSubview(payModeLabel)
        self.addSubview(payLogoImageView)
        payLogoImageView.snp.makeConstraints({ (make) in
           
            make.left.equalTo(self.snp.left).offset(10)
            make.centerY.equalTo(self)
        })
        
        
        payModeLabel.snp.makeConstraints({ (make) in
            //            make.top.equalTo(self.snp.top).offset(11.6)
            make.left.equalTo(payLogoImageView.snp.right).offset(10)
            //            make.width.equalTo(50)
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
