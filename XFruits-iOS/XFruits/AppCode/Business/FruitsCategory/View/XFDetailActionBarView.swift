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

    var actionHandler: ((Int) -> Void)?
    
    lazy var link2ChatBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.imageWithNamed("service_chat"), for: .normal)
        btn.layer.borderWidth = XFConstants.UI.singleLineAdjustOffset
        btn.layer.borderColor = XFConstants.Color.darkGray.cgColor
        btn.tag = 0
        btn.addTarget(self, action: #selector(actionHandler(btn:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var add2CollectionBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.imageWithNamed("service_collect"), for: .normal)
        btn.layer.borderWidth = XFConstants.UI.singleLineAdjustOffset
        btn.layer.borderColor = XFConstants.Color.darkGray.cgColor
        btn.tag = 1
        btn.addTarget(self, action: #selector(actionHandler(btn:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var add2CartBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("放进果篮", for: .normal)
        btn.setTitleColor(XFConstants.Color.darkGray, for: .normal)
        btn.titleLabel?.font = XFConstants.Font.pfn14
        btn.layer.borderWidth = XFConstants.UI.singleLineAdjustOffset
        btn.layer.borderColor = XFConstants.Color.darkGray.cgColor
        btn.tag = 2
        btn.addTarget(self, action: #selector(actionHandler(btn:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var link2BuyBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.backgroundColor = XFConstants.Color.salmon
        btn.setTitle("立即购买", for: .normal)
        btn.titleLabel?.font = XFConstants.Font.pfn14
        btn.layer.borderWidth = XFConstants.UI.singleLineAdjustOffset
        btn.layer.borderColor = XFConstants.Color.darkGray.cgColor
        btn.tag = 3
        btn.addTarget(self, action: #selector(actionHandler(btn:)), for: .touchUpInside)
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
    
    @objc fileprivate func actionHandler(btn:UIButton) {
        if let action = actionHandler {
            action(btn.tag)
        }
    }
    
    fileprivate func customInit(){
        
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
            make.width.equalTo(self.link2BuyBtn.snp.width)
        }
        link2BuyBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.add2CartBtn.snp.right)
            make.right.equalTo(self)
            make.top.bottom.equalTo(self)
            make.width.equalTo(self.add2CartBtn.snp.width)
        }
    }

}
