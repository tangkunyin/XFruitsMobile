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
    
    var actionHandler: ((Int) -> Void)?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpUI();
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI();
    }
    
    
    //    lazy var self:UIScrollView = {
    //        let scrollView = UIScrollView()
    //        scrollView.backgroundColor = UIColor.white
    //        return scrollView
    //    }()
    
    @objc fileprivate func pagerClicked(_ tap:UITapGestureRecognizer) {
        print("a")
        //        if let pagerView = tap.view, let pagerClicked = self.pagerDidClicked {
        //            pagerClicked(pagerView.tag)
        //        }
    }
    
    lazy var avatarTipLabel:UILabel = {
        let  label = UILabel()
        label.text = "头像"
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        label.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(pagerClicked(_:))))
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var avatarBtn:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.imageWithNamed("defaultAvatar"), for: .normal)
        btn.addTarget(self, action: #selector(actionHandler(btn:)), for: .touchUpInside)
        
        return btn
    }()
    
    @objc fileprivate func actionHandler(btn:UIButton) {
        
        
        UIAlertController.alertSheet(title: "提示", message: "修改头像", buttons: ["相机","相册"], dismiss: { (btnIndex) in
            print(btnIndex);
            if (btnIndex == 0){
                
            }
            else if (btnIndex == 1 ){
                
            }
            
        }) { 
            print("b")
        }
 
        //  相册，拍照，取消
        if let action = actionHandler {
            action(btn.tag)
        }
    }
    
    lazy var nicknameTipLabel:UILabel = {
        let  label = UILabel()
        label.text = "昵称"
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        
        
        return label
    }()
    
    lazy var nicknameLabel:UILabel = {
        let  label = UILabel()
        label.text = "zhaojian"
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        label.textAlignment = .right
        label.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(pagerClicked(_:))))
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var changePwdTipLabel:UILabel = {
        let  label = UILabel()
        label.text = "修改密码"
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        label.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(pagerClicked(_:))))
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    
    lazy var mobileTipLabel:UILabel = {
        let  label = UILabel()
        label.text = "手机号码"
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        
        
        return label
    }()
    
    lazy var mobileLabel:UILabel = {
        let  label = UILabel()
        label.text = "18519191442"
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        label.textAlignment = .right
        label.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(pagerClicked(_:))))
        label.isUserInteractionEnabled = true
        return label
    }()
    
    
    lazy var signatureTipLabel:UILabel = {
        let  label = UILabel()
        label.text = "个性签名"
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        
        
        return label
    }()
    
    lazy var signatureLabel:UILabel = {
        let  label = UILabel()
        label.text = "骑马喝酒走天涯"
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        label.textAlignment = .right
        label.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(pagerClicked(_:))))
        label.isUserInteractionEnabled = true
        return label
    }()
    
    func setUpUI()  {
        
        let line1:UIView = createSeperateLine()
        self.addSubview(avatarTipLabel)
        
        avatarTipLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(self.snp.top).offset(22)
            make.left.equalTo(self.snp.left).offset(13)
            make.height.equalTo(19)
            make.width.equalTo(70)
            
        })
        
        self.addSubview(avatarBtn)
        
        avatarBtn.snp.makeConstraints({ (make) in
            make.top.equalTo(self.snp.top).offset(12)
            
            make.right.equalTo(self.snp.right).offset(-13)
            make.width.height.equalTo(40)
            
        })
        
        self.addSubview(line1)
        line1.snp.makeConstraints { (make) in
            make.top.equalTo(avatarBtn.snp.bottom).offset(12)
            make.height.equalTo(0.4)
            make.left.right.equalTo(self)
        }
        
      
        let line2:UIView = createSeperateLine()
        
        self.addSubview(nicknameTipLabel)
        nicknameTipLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(line1.snp.bottom).offset(12)
            make.left.equalTo(self.snp.left).offset(13)
            
            make.width.equalTo(70)
            make.height.equalTo(19)
        })
        
        
        self.addSubview(nicknameLabel)
        nicknameLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(line1.snp.bottom).offset(12)
            make.left.equalTo(nicknameTipLabel.snp.right).offset(13)
            make.right.equalTo(self.snp.right).offset(-13)
            make.height.equalTo(19)
        })
        
        
        
        self.addSubview(line2)
        
        line2.snp.makeConstraints { (make) in
            make.top.equalTo(nicknameTipLabel.snp.bottom).offset(10)
            make.height.equalTo(0.4)
            make.left.right.equalTo(self)
        }
        
        let line3:UIView = createSeperateLine()
        self.addSubview(changePwdTipLabel)
        changePwdTipLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(line2.snp.bottom).offset(12)
            make.left.equalTo(self.snp.left).offset(13)
            make.right.equalTo(self.snp.right).offset(-13)
            make.width.equalTo(70)
            make.height.equalTo(19)
        })
        self.addSubview(line3)
        line3.snp.makeConstraints { (make) in
            make.top.equalTo(changePwdTipLabel.snp.bottom).offset(10)
            make.height.equalTo(0.4)
            make.left.right.equalTo(self)
        }
        
      
        let line4:UIView = createSeperateLine()
        self.addSubview(mobileTipLabel)
        mobileTipLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(line3.snp.bottom).offset(12)
            make.left.equalTo(self.snp.left).offset(13)
            make.width.equalTo(70)
            make.height.equalTo(19)
        })
       
        self.addSubview(mobileLabel)
        self.addSubview(line4)
        line4.snp.makeConstraints { (make) in
            make.top.equalTo(mobileTipLabel.snp.bottom).offset(10)
            make.height.equalTo(0.4)
            make.left.right.equalTo(self)
        }
        
        mobileLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(line3.snp.bottom).offset(12)
            make.left.equalTo(mobileTipLabel.snp.right).offset(13)
            make.right.equalTo(self.snp.right).offset(-13)
            make.height.equalTo(19)
        })
       
//        let line5:UIView = createSeperateLine()
       
        self.addSubview(signatureTipLabel)
        signatureTipLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(line4.snp.bottom).offset(12)
            make.left.equalTo(self.snp.left).offset(13)
            make.width.equalTo(70)
            make.height.equalTo(19)
        })
        
        
        self.addSubview(signatureLabel)
        signatureLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(line4.snp.bottom).offset(12)
            make.left.equalTo(mobileTipLabel.snp.right).offset(13)
            make.right.equalTo(self.snp.right).offset(-13)
            make.height.equalTo(19)
        })
         
        
    }
    
}
