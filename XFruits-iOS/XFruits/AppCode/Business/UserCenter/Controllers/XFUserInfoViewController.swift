//
//  XFUserInfoViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/8/20.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit

/// 用户信息、退出、头像上传
class XFUserInfoViewController: XFBaseSubViewController {

    lazy var loginOutBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("退出登录", for: .normal)
        btn.titleLabel?.font = XFConstants.Font.pfn16
        btn.setTitleColor(XFConstants.Color.salmon, for: .normal)
        btn.layer.cornerRadius = 6
        btn.layer.borderWidth = 1
        btn.layer.borderColor = XFConstants.Color.salmon.cgColor
        btn.addTarget(self, action: #selector(onLoginOut), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "个人资料"
    
        view.addSubview(loginOutBtn)
        loginOutBtn.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.right.bottom.equalTo(view).offset(-20)
            make.height.equalTo(45)
        }
    }

    
    @objc private func onLoginOut(){
        XFUserGlobal.shared.signOff()
        backToParentController()
    }
    

}
