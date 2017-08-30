//
//  XFPayResultViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/8/15.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit

class XFPayResultViewController: XFBaseViewController {

    var isSuccess: Bool = true {
        didSet {
            if isSuccess {
                payResultSign.image = UIImage.imageWithNamed("success_big")
                payResultTip.textColor = XFConstants.Color.green
                payResultTip.text = "支付成功"
            } else {
                payResultSign.image = UIImage.imageWithNamed("fail_big")
                payResultTip.textColor = XFConstants.Color.reddishPink
                payResultTip.text = "支付失败"
            }
        }
    }
    
    var payType: Int = 1 {
        didSet {
            switch payType {
            case 1:
                payWayContent.text = "支付宝"
            case 2:
                payWayContent.text = "微信"
            default:
                payWayContent.text = "未知"
            }
        }
    }
    
    var totalAmount: String = "0.00" {
        didSet {
            payAmountText.text = "¥ \(totalAmount)"
        }
    }
    
    var errorMsg: String = "" {
        didSet {
            if errorMsg.characters.count > 0 {
                payDescription.text = errorMsg
            }
        }
    }
    
    var onPageClosed: (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstrains()
    }

    
    @objc fileprivate func onPageCloseClick() {
        weak var weakSelf = self
        dismiss(animated: false) {
            if let action = weakSelf?.onPageClosed {
                action()
            }
        }
    }
    
    fileprivate func makeConstrains() {
        view.addSubview(payResultSign)
        view.addSubview(payResultTip)
        view.addSubview(payDescription)
        view.addSubview(payAmountText)
        view.addSubview(separatorLine)
        view.addSubview(payWayTitle)
        view.addSubview(payWayContent)
        view.addSubview(dismissBtn)
        
        payResultSign.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(120)
            make.size.equalTo(70)
        }
        payResultTip.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(payResultSign.snp.bottom).offset(20)
            make.width.equalTo(100)
        }
        payDescription.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(payResultTip.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 250, height: 44))
        }
        payAmountText.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(payDescription.snp.bottom).offset(10)
            make.width.equalTo(200)
        }
        separatorLine.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.top.equalTo(payAmountText.snp.bottom).offset(30)
            make.left.equalTo(view).offset(30)
            make.right.equalTo(view).offset(-30)
        }
        payWayTitle.snp.makeConstraints { (make) in
            make.top.equalTo(separatorLine.snp.bottom).offset(20)
            make.left.equalTo(separatorLine)
            make.width.equalTo(120)
        }
        payWayContent.snp.makeConstraints { (make) in
            make.top.equalTo(separatorLine.snp.bottom).offset(20)
            make.right.equalTo(separatorLine)
            make.width.equalTo(120)
        }
        dismissBtn.snp.makeConstraints { (make) in
            make.size.equalTo(24)
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-100)
        }
    }
    
    fileprivate lazy var payResultSign: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    fileprivate lazy var payResultTip: UILabel = {
        let label = UILabel()
        label.font = XFConstants.Font.pfn16
        label.textAlignment = .center
        return label
    }()
    
    fileprivate lazy var payDescription: UILabel = {
        let label = UILabel()
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.greyishBrown
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    fileprivate lazy var payAmountText: UILabel = {
        let label = UILabel()
        label.font = pfbFontWithSize(48)
        label.textColor = XFConstants.Color.darkGray
        label.textAlignment = .center
        return label
    }()
    
    fileprivate lazy var separatorLine: UIView = {
        return createSeperateLine()
    }()
    
    fileprivate lazy var payWayTitle: UILabel = {
        let label = UILabel()
        label.font = XFConstants.Font.pfn16
        label.textColor = XFConstants.Color.darkGray
        label.textAlignment = .left
        label.text = "付款方式"
        return label
    }()
    
    fileprivate lazy var payWayContent: UILabel = {
        let label = UILabel()
        label.font = XFConstants.Font.pfn16
        label.textColor = XFConstants.Color.darkGray
        label.textAlignment = .right
        return label
    }()
    
    fileprivate lazy var dismissBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.imageWithNamed("dialog_close"), for: .normal)
        btn.addTarget(self, action: #selector(onPageCloseClick), for: .touchUpInside)
        return btn
    }()
}
