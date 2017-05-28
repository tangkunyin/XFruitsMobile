//
//  XFDetailActionBarView.swift
//  XFruits
//
//  Created by tangkunyin on 28/05/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit

/// 详情页底部事件响应区
class XFDetailActionBarView: UIView {

    lazy var link2ChatBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        return btn
    }()
    
    lazy var add2CollectionBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        return btn
    }()
    
    lazy var add2CartBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        return btn
    }()
    
    lazy var link2BuyBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        return btn
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
        layer.borderWidth = XFConstants.UI.singleLineAdjustOffset
        layer.borderColor = grayColor(102).cgColor
        
        addSubview(link2ChatBtn)
        addSubview(add2CollectionBtn)
        addSubview(add2CartBtn)
        addSubview(link2BuyBtn)
        
        link2ChatBtn.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
            make.right.equalTo(self.add2CollectionBtn.snp.left)
            make.width.equalTo(45)
        }
        add2CollectionBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.link2ChatBtn.snp.right)
            make.width.equalTo(self.link2ChatBtn.snp.width)
            make.top.bottom.equalTo(self)
        }
        add2CartBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.add2CollectionBtn.snp.right)
            make.right.equalTo(self.link2BuyBtn.snp.left)
            make.top.bottom.equalTo(self)
        }
        link2BuyBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.add2CartBtn.snp.right)
            make.right.equalTo(self)
            make.top.bottom.equalTo(self)
            make.width.greaterThanOrEqualTo(142)
        }
    }

}
