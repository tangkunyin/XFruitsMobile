//
//  XFEmptyAddressView.swift
//  XFruits
//
//  Created by zhaojian on 8/10/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class XFEmptyAddressView: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpUI();
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI();
    }
    
    // 地址为空时，空白页背景
    lazy var emptyBgView:UIView = {
        let  emptyBgView = UIView()
        emptyBgView.backgroundColor = UIColor.white
        return emptyBgView
    }()
    
    // 地址为空时，居中的提示 label
    lazy var emptyAddressTipLabel:UILabel = {
        let emptyAddressTipLabel = UILabel()
        emptyAddressTipLabel.text = "快去添加地址吧~"
        emptyAddressTipLabel.textAlignment = .center
        emptyAddressTipLabel.textColor = XFConstants.Color.greyishBrown
        return emptyAddressTipLabel
    }()
    
    // 地址为空时，居中的图片
    lazy var emptyAddressImageView:UIImageView = {
        let  emptyAddressImageView = UIImageView.init(image: UIImage.imageWithNamed("emptyAddress"))
        return emptyAddressImageView
    }()
    
    
    func setUpUI()  {
        self.addSubview(emptyBgView)
        emptyBgView.addSubview(emptyAddressTipLabel)
        
        emptyBgView.snp.makeConstraints({ (make) in
            make.center.size.equalTo(self)
        })
        
        // 为空时候的中间提示的 label
        emptyAddressTipLabel.snp.makeConstraints({ (make) in
            make.left.equalTo(emptyBgView.snp.left)
            make.right.equalTo(emptyBgView.snp.right)
            make.center.equalTo(self)
            make.height.equalTo(30)
            
        })
        
        emptyBgView.addSubview(emptyAddressImageView)
        emptyAddressImageView.snp.makeConstraints({ (make) in
            make.bottom.equalTo(emptyAddressTipLabel.snp.top).offset(-5)
            
            make.centerX.equalTo(self)
            make.width.height.equalTo(100)
        })
    }
    
    
}
