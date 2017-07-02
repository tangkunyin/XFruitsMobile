//
//  XFAddAddressViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class XFAddAddressViewController: XFBaseSubViewController    {
    
    var editStyle: NSString?  // 0 为增加模式，1为编辑模式。
    var leftTipArray:NSArray? // 左侧提示
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "新增地址"
        
        
        // 测试用。
        let eidtAddressView = XFEditMyAddressView()
        self.view.addSubview(eidtAddressView)
        
        eidtAddressView.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        })
        
        // 导航栏右侧保存按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "保存", style: .plain, target: self, action: #selector(saveAddress(sender:)))
        
        
    }
    
    // 导航栏右侧按钮-保存-触发的事件
    func saveAddress(sender:UIButton?) {
        dPrint("save")
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
