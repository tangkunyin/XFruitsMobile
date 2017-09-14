//
//  XFUserInfoView.swift
//  XFruits
//
//  Created by zhaojian on 9/14/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

/*
 
 第一行：头像（点击可以放大，点击本行，可以修改头像）
 第二行：昵称   （点击可以修改昵称）
 第三行：修改密码（点击可以修改密码）
 第四行：手机号码
 第五行：个性签名
 底部：退出
 
 */
class XFUserInfoView: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpUI();
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI();
    }
    
    
    lazy var backgroudScrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.white
        return scrollView
    }()
  
    lazy var avatarTipLabel:UILabel = {
       let  label = UILabel()
        label.text = "头像"
        label.font = XFConstants.Font.pfn12
        label.textColor = XFConstants.Color.darkGray
        return label
    }()
    
    lazy var avatarBtn:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.imageWithNamed(""), for: .normal)
        return btn
    }()
    
    lazy var nicknameTipLabel:UILabel = {
        let  label = UILabel()
        label.text = "昵称"
        label.font = XFConstants.Font.pfn12
        label.textColor = XFConstants.Color.darkGray
        return label
    }()
    
    lazy var nicknameLabel:UILabel = {
        let  label = UILabel()
        label.text = "zhaojian"
        label.font = XFConstants.Font.pfn12
        label.textColor = XFConstants.Color.darkGray
        return label
    }()
    
    lazy var changePwdTipLabel:UILabel = {
        let  label = UILabel()
        label.text = "修改密码"
        label.font = XFConstants.Font.pfn12
        label.textColor = XFConstants.Color.darkGray
        return label
    }()
    
    
    lazy var mobileTipLabel:UILabel = {
        let  label = UILabel()
        label.text = "手机号码"
        label.font = XFConstants.Font.pfn12
        label.textColor = XFConstants.Color.darkGray
        return label
    }()
    
    lazy var mobileLabel:UILabel = {
        let  label = UILabel()
        label.text = "18519191442"
        label.font = XFConstants.Font.pfn12
        label.textColor = XFConstants.Color.darkGray
        return label
    }()
    
    
    lazy var signatureTipLabel:UILabel = {
        let  label = UILabel()
        label.text = "个性签名"
        label.font = XFConstants.Font.pfn12
        label.textColor = XFConstants.Color.darkGray
        return label
    }()
    
    lazy var signatureLabel:UILabel = {
        let  label = UILabel()
        label.text = "骑马喝酒走天涯"
        label.font = XFConstants.Font.pfn12
        label.textColor = XFConstants.Color.darkGray
        return label
    }()
    
    func setUpUI()  {
         let seperateLine1:UIView = createSeperateLine()
        
        self.addSubview(avatarTipLabel)
        self.addSubview(avatarBtn)
        self.addSubview(seperateLine1)
        
//        specificationDescLabelBottomLine.snp.makeConstraints { (make) in
//            make.width.equalTo(self)
//            make.height.equalTo(0.4)
//            make.bottom.equalTo(self.serviceTitleLabel.snp.top)
//        }
        let seperateLine2:UIView = createSeperateLine()

        self.addSubview(nicknameTipLabel)
        self.addSubview(nicknameLabel)
         self.addSubview(seperateLine2)
        
        let seperateLine3:UIView = createSeperateLine()
        self.addSubview(changePwdTipLabel)
         self.addSubview(seperateLine3)
        
        let seperateLine4:UIView = createSeperateLine()
        self.addSubview(mobileTipLabel)
        self.addSubview(mobileLabel)
         self.addSubview(seperateLine4)
        
        let seperateLine5:UIView = createSeperateLine()
        self.addSubview(signatureTipLabel)
        self.addSubview(signatureLabel)
         self.addSubview(seperateLine5)
    }

}
