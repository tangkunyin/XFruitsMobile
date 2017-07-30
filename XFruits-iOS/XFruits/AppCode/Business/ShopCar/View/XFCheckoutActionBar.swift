//
//  XFCheckoutActionBar.swift
//  XFruits
//
//  Created by tangkunyin on 2017/7/18.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit

class XFCheckoutActionBar: XFShopCartActionBar {

    override func customInit() {
    
        backgroundColor = XFConstants.Color.commonBackground
        addSubview(pricelabel)
        addSubview(actionBtn)
        
        pricelabel.textAlignment = .left
        actionBtn.setTitle("去付款", for: .normal)
        
        pricelabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.top.bottom.equalTo(self)
            make.width.equalTo(160)
        }
        actionBtn.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(self)
            make.width.equalTo(100)
        }
    }

    func updateActualAmount(totalAmount amount: Float, expressFee: Float? = 0.00) {
        pricelabel.text = String(format:"实付： ¥ %.2f", amount + expressFee!)
    }
    
}
