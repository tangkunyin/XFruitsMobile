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
    
    var onConfirmBarPress: (()->Void)?
    
    lazy var countlabel:UILabel = {
        let label = UILabel()
        label.textColor = XFConstants.Color.darkGray
        label.textAlignment = .left
        label.font = XFConstants.Font.pfn14
        label.text = "全部(0)"
        return label
    }()
    
    lazy var pricelabel:UILabel = {
        let label = UILabel()
        label.textColor = XFConstants.Color.salmon
        label.textAlignment = .center
        label.font = XFConstants.Font.pfn14
        label.text = "¥ 00.00"
        return label
    }()
    
    lazy var actionBtn:UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.backgroundColor = XFConstants.Color.salmon
        btn.setTitle("下 单", for: .normal)
        btn.setTitleColor(grayColor(255), for: .normal)
        btn.titleLabel?.font = XFConstants.Font.pfn14
        btn.addTarget(self, action: #selector(onClickAction), for: .touchUpInside)
        return btn
    }()

    func update(total: Int, amount: Float)  {
        countlabel.text = "全部(\(total))"
        pricelabel.text = String(format:"¥ %.2f",amount)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    func customInit(){
        backgroundColor = XFConstants.Color.commonBackground
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
    
    @objc fileprivate func onClickAction() {
        if let confirmPress = onConfirmBarPress {
            confirmPress()
        }
    }
}
