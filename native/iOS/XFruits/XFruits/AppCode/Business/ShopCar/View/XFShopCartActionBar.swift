//
//  XFShopCartActionBar.swift
//  XFruits
//
//  Created by tangkunyin on 21/05/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit


class XFShopCartActionBar: UIView {
    
    lazy var countlabel:UILabel = {
        let label = UILabel()
        label.textColor = grayColor(102)
        label.textAlignment = .left
        label.font = XFConstants.Font.mainMenuFont
        label.text = "全部(0)"
        return label
    }()
    
    lazy var pricelabel:UILabel = {
        let label = UILabel()
        label.textColor = XFConstants.Color.salmon
        label.textAlignment = .center
        label.font = XFConstants.Font.mainMenuFont
        label.text = "¥ 168.00"
        return label
    }()
    
    lazy var actionBtn:UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.backgroundColor = XFConstants.Color.salmon
        btn.setTitle("下 单", for: .normal)
        btn.setTitleColor(grayColor(255), for: .normal)
        btn.titleLabel?.font = XFConstants.Font.mainMenuFont
        btn.addTarget(self, action: #selector(onCartBtnClicked(_:)), for: .touchUpInside)
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
    
    fileprivate func customInit(){
        backgroundColor = XFConstants.Color.commonBgColor
        addSubview(countlabel)
        addSubview(pricelabel)
        addSubview(actionBtn)
        
        countlabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self.pricelabel.snp.left)
        }
        pricelabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(self.countlabel.snp.right)
            make.width.equalTo(80)
        }
        actionBtn.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(self)
            make.left.equalTo(self.pricelabel.snp.right)
            make.width.equalTo(100)
        }
    }
    
    @objc private func onCartBtnClicked(_ btn:UIButton){
        print("Hello")
    }
    

}
