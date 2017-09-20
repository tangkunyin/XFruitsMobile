//
//  XFCouponListViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/9/19.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit


class XFCouponListViewController: XFBaseSubViewController {

    lazy var couponInputView: UITextField = {
        let textField = UITextField()
        textField.tag = 1
        textField.delegate = self
        textField.layer.borderColor = XFConstants.Color.pinkishGrey.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 2, 0);
        textField.returnKeyType = .done
        textField.attributedPlaceholder = NSAttributedString(string: "请输入优惠券码",
                                                             attributes:xfAttributes(fontColor: XFConstants.Color.pinkishGrey))
        return textField
    }()
    
    lazy var couponReceiveBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("兑 换", for: .normal)
        btn.backgroundColor = XFConstants.Color.salmon
        btn.titleLabel?.textColor = UIColor.white
        btn.layer.cornerRadius = 15
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(onExchangeCoupon), for:.touchUpInside)
        return btn
    }()
    
    lazy var couponListView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = UIColor.clear
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 88
        tableView.register(XFCouponItemCellView.self, forCellReuseIdentifier: "_XFCouponItemCellView")
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的优惠券"
        
        view.addSubview(couponInputView)
        view.addSubview(couponReceiveBtn)
        view.addSubview(couponListView)
        couponInputView.snp.makeConstraints { (make) in
            make.left.top.equalTo(view).offset(15)
            make.height.equalTo(35)
            make.right.equalTo(couponReceiveBtn.snp.left).offset(-10)
        }
        couponReceiveBtn.snp.makeConstraints { (make) in
            make.top.height.equalTo(couponInputView)
            make.right.equalTo(view).offset(-15)
            make.width.equalTo(75)
            make.left.equalTo(couponInputView.snp.right).offset(10)
        }
        couponListView.snp.makeConstraints { (make) in
            make.left.equalTo(couponInputView)
            make.right.equalTo(couponReceiveBtn)
            make.top.equalTo(couponInputView.snp.bottom).offset(15)
            make.bottom.equalTo(view)
        }
        
    }

    @objc private func onExchangeCoupon() {
        if let couponCode = couponInputView.text, couponCode.characters.count > 0  {
            
        } else {
            showError("优惠券码不能为空喔~")
        }
    }
}

extension XFCouponListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "_XFCouponItemCellView", for: indexPath) as! XFCouponItemCellView
        
        
        
        return cell
    }
    
}


extension XFCouponListViewController: UITextFieldDelegate {
    
    
}