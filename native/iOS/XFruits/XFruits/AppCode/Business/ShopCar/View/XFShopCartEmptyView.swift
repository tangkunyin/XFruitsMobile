//
//  XFShopCartEmptyView.swift
//  XFruits
//
//  Created by tangkunyin on 2017/7/16.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit

class XFShopCartEmptyView: UIView {

    
    lazy var tipImageView: UIImageView = {
        let imageView = UIImageView.init(image: UIImage.imageWithNamed(""))
        return imageView
    }()
    
    
    lazy var tipLabel: UILabel = {
        let label = UILabel()
        label.font = XFConstants.Font.titleFont
        label.textColor = XFConstants.Color.paleGrey
        label.textAlignment = .center
        label.text = "拾个农夫提醒：您的果篮还未采摘水果喔~"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    private func customInit(){
        addSubview(tipImageView)
        addSubview(tipLabel)
        tipImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 120, height: 260))
            make.top.equalTo(self).offset(50)
            make.centerX.equalTo(self)
        }
        tipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.tipImageView.snp.bottom).offset(20)
            make.left.right.equalTo(self)
            make.height.equalTo(44)
        }
    }
    
}
