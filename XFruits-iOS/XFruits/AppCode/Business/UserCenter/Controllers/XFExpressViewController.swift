//
//  XFExpressViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/8/20.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit

class XFExpressViewController: XFBaseSubViewController {

    var orderId: String = ""
    
    fileprivate var expressData: XFExpress?
    
    fileprivate lazy var request: XFOrderSerivice = {
        return XFOrderSerivice()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "快递信息"
    
        request.getExpressDetail(params: ["orderId":orderId]) { (data) in
            dPrint(data)
        }
        
    }

    

}
