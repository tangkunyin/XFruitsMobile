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

enum LABEL_TAG: Int {
    case avatar = 100,avatarExpand, nickname,sex,email, changePwd, mobile, signature
}

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
    
   
    lazy var avatarTipLabel:UILabel = {
        let  label = UILabel()
        label.text = "头像"
        label.font = XFConstants.Font.pfn14
        label.tag = LABEL_TAG.avatar.rawValue
        label.textColor = XFConstants.Color.darkGray
        label.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(labelCellClicked(_:))))
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var avatarImageView:UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage.imageWithNamed("defaultAvatar2")
                imageView.layer.borderColor = UIColor.white.cgColor
                imageView.layer.shadowColor = UIColor.lightGray.cgColor
                imageView.layer.borderWidth = 1
                imageView.layer.shadowOffset = CGSize.init(width: 3, height: 3)
                imageView.layer.shadowOpacity = 1
        imageView.isUserInteractionEnabled = true
        imageView.tag = LABEL_TAG.avatarExpand.rawValue
        imageView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(labelCellClicked(_:))))

        return imageView
    }()
    
    
    lazy var nicknameTipLabel:UILabel = {
        let  label = UILabel()
        label.text = "昵称"
        label.tag = LABEL_TAG.nickname.rawValue
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        return label
    }()
    
    lazy var nicknameLabel:UILabel = {
        let  label = UILabel()
        label.text = "赵健"
        label.tag = LABEL_TAG.nickname.rawValue
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        label.textAlignment = .right
        label.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(labelCellClicked(_:))))
        label.isUserInteractionEnabled = true
        return label
    }()
    
    
    
    lazy var sexTipLabel:UILabel = {
        let  label = UILabel()
        label.text = "性别"
        label.tag = LABEL_TAG.sex.rawValue
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        return label
    }()
    
    lazy var sexLabel:UILabel = {
        let  label = UILabel()
        label.text = "男"
        label.tag = LABEL_TAG.sex.rawValue
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        label.textAlignment = .right
        label.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(labelCellClicked(_:))))
        label.isUserInteractionEnabled = true
        return label
    }()
    
    
    lazy var emailTipLabel:UILabel = {
        let  label = UILabel()
        label.text = "邮箱"
        label.tag = LABEL_TAG.email.rawValue
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        return label
    }()
    
    lazy var emailLabel:UILabel = {
        let  label = UILabel()
        label.text = ""
        label.tag = LABEL_TAG.email.rawValue
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        label.textAlignment = .right
        label.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(labelCellClicked(_:))))
        label.isUserInteractionEnabled = true
        return label
    }()

    
    
//    lazy var changePwdTipLabel:UILabel = {
//        let  label = UILabel()
//        label.text = "修改密码"
//        label.tag = LABEL_TAG.changePwd.rawValue
//        label.font = XFConstants.Font.pfn14
//        label.textColor = XFConstants.Color.darkGray
//        label.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(labelCellClicked(_:))))
//        label.isUserInteractionEnabled = true
//        return label
//    }()
    
    
    lazy var mobileTipLabel:UILabel = {
        let  label = UILabel()
        label.text = "手机号码"
        label.tag = LABEL_TAG.mobile.rawValue
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        return label
    }()
    
    lazy var mobileLabel:UILabel = {
        let  label = UILabel()
        label.text = "18519191442"
        label.tag = LABEL_TAG.mobile.rawValue

        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        label.textAlignment = .right
        label.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(labelCellClicked(_:))))
        label.isUserInteractionEnabled = true
        return label
    }()
    
    
    lazy var signatureTipLabel:UILabel = {
        let  label = UILabel()
        label.text = "个性签名"
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        label.tag = LABEL_TAG.signature.rawValue
        return label
    }()
    
    lazy var signatureLabel:UILabel = {
        let  label = UILabel()
        label.text = "骑马喝酒走天涯"
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        label.textAlignment = .right
        label.tag = LABEL_TAG.signature.rawValue

        label.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(labelCellClicked(_:))))
        label.isUserInteractionEnabled = true
        return label
    }()
    
    func setUpUI()  {
       
        self.addSubview(avatarImageView)
        
        let animation = CABasicAnimation.init(keyPath: "opacity")
        animation.fromValue = NSNumber.init(value: 1)
        animation.toValue = NSNumber.init(value: 0)
        animation.autoreverses = true
        animation.duration = 3.0
        animation.repeatCount = MAXFLOAT
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        avatarImageView.layer.add(animation, forKey: "aAlpha")
        
        avatarImageView.layer.cornerRadius = 40/2
        avatarImageView.layer.masksToBounds = true
        avatarImageView.snp.makeConstraints({ (make) in
            make.top.equalTo(self.snp.top).offset(12)
            make.right.equalTo(self.snp.right).offset(-13)
            make.width.height.equalTo(40)
        })
        
        self.addSubview(avatarTipLabel)
        avatarTipLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(self.snp.top).offset(16)
            make.left.equalTo(self.snp.left).offset(13)
            make.right.equalTo(avatarImageView.snp.left).offset(-15)
            make.height.equalTo(30)
        })
        
        let line1:UIView = createSeperateLine()
        self.addSubview(line1)
        line1.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImageView.snp.bottom).offset(10)
            make.height.equalTo(0.4)
            make.left.right.equalTo(self)
        }
        
      
        
        self.addSubview(nicknameTipLabel)
        nicknameTipLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(line1.snp.bottom).offset(10)
            make.left.equalTo(self.snp.left).offset(13)
            make.width.equalTo(70)
            make.height.equalTo(21)
        })
        self.addSubview(nicknameLabel)
        nicknameLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(line1.snp.bottom).offset(10)
            make.left.equalTo(nicknameTipLabel.snp.right).offset(13)
            make.right.equalTo(self.snp.right).offset(-13)
            make.height.equalTo(21)
        })
        
        
        let line2:UIView = createSeperateLine()
        self.addSubview(line2)
        line2.snp.makeConstraints { (make) in
            make.top.equalTo(nicknameTipLabel.snp.bottom).offset(10)
            make.height.equalTo(0.4)
            make.left.right.equalTo(self)
        }
        
        
        self.addSubview(sexTipLabel)
        sexTipLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(line2.snp.bottom).offset(10)
            make.left.equalTo(self.snp.left).offset(13)
            make.width.equalTo(70)

//            make.right.equalTo(self.snp.right).offset(-50)
            make.height.equalTo(21)
        })
        
        self.addSubview(sexLabel)
        sexLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(line2.snp.bottom).offset(10)
            make.left.equalTo(nicknameTipLabel.snp.right).offset(13)
            make.right.equalTo(self.snp.right).offset(-13)
            make.height.equalTo(21)
        })
        let line3:UIView = createSeperateLine()
        self.addSubview(line3)
        line3.snp.makeConstraints { (make) in
            make.top.equalTo(sexTipLabel.snp.bottom).offset(10)
            make.height.equalTo(0.4)
            make.left.right.equalTo(self)
        }
        
        self.addSubview(emailTipLabel)
        emailTipLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(line3.snp.bottom).offset(10)
            make.left.equalTo(self.snp.left).offset(13)
            
            make.width.equalTo(70)
            make.height.equalTo(21)
        })
        self.addSubview(emailLabel)
        emailLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(line3.snp.bottom).offset(10)
            make.left.equalTo(nicknameTipLabel.snp.right).offset(13)
            make.right.equalTo(self.snp.right).offset(-13)
            make.height.equalTo(21)
        })
        
        let line4:UIView = createSeperateLine()
        self.addSubview(line4)
        line4.snp.makeConstraints { (make) in
            make.top.equalTo(emailTipLabel.snp.bottom).offset(10)
            make.height.equalTo(0.4)
            make.left.right.equalTo(self)
        }
        
      
        
        self.addSubview(mobileTipLabel)
        mobileTipLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(line4.snp.bottom).offset(10)
            make.left.equalTo(self.snp.left).offset(13)
            make.width.equalTo(70)
            make.height.equalTo(21)
        })
       
        self.addSubview(mobileLabel)
        mobileLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(line4.snp.bottom).offset(10)
            make.left.equalTo(mobileTipLabel.snp.right).offset(13)
            make.right.equalTo(self.snp.right).offset(-13)
            make.height.equalTo(21)
        })
        
        let line5:UIView = createSeperateLine()
        self.addSubview(line5)
        
        line5.snp.makeConstraints { (make) in
            make.top.equalTo(mobileTipLabel.snp.bottom).offset(10)
            make.height.equalTo(0.4)
            make.left.right.equalTo(self)
        }
        
        self.addSubview(signatureTipLabel)
        signatureTipLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(line5.snp.bottom).offset(10)
            make.left.equalTo(self.snp.left).offset(13)
            make.width.equalTo(70)
            make.height.equalTo(21)
        })
        
//        self.addSubview(signatureLabel)
//        signatureLabel.snp.makeConstraints({ (make) in
//            make.top.equalTo(line5.snp.bottom).offset(10)
//            make.left.equalTo(mobileTipLabel.snp.right).offset(13)
//            make.right.equalTo(self.snp.right).offset(-13)
//            make.height.equalTo(21)
//        })
    }
    
    
    func setUserInfo(data:XFUser)  {
        // avatarImageView
        
        
        nicknameLabel.text = data.username
        sexLabel.text = data.sex == 1 ?"男":"女"
        mobileLabel.text = data.cellPhone
        emailLabel.text = data.email
        
    }
    

    @objc fileprivate func avatarEvent(btn:UIButton) {
        // 头像放大
    }
    
    @objc fileprivate func labelCellClicked(_ tap:UITapGestureRecognizer) {
        print("a")
        if let tapLabelView = tap.view  {
            let tag:Int = tapLabelView.tag
            if tag == LABEL_TAG.avatar.rawValue {
                changeAvatarActionSheetShow(tag: tag)
            }
            else if tag == LABEL_TAG.avatarExpand.rawValue{
//                let exi:XFExpandImage =  XFExpandImage()   // 放大缩小不了是个bug，虽然还没找到原因
//                exi.scanBigImageWithImageView(currentImageView: avatarImageView, alpha: 0.5)
            }
            else if tag == LABEL_TAG.nickname.rawValue{
                if let action = self.actionHandler {
                    action(LABEL_TAG.nickname.rawValue)
                }
             
            }
            else if tag == LABEL_TAG.email.rawValue{
                if let action = self.actionHandler {
                    action(LABEL_TAG.email.rawValue)
                }
            }
            else if tag == LABEL_TAG.sex.rawValue {
                if let action = self.actionHandler {
                    action(LABEL_TAG.sex.rawValue)
                }
            }
            else if tag == LABEL_TAG.signature.rawValue{
                if let action = self.actionHandler {
                    action(LABEL_TAG.signature.rawValue)
                }
            }
        }
    }
    
    func changeAvatarActionSheetShow(tag:Int) {
        /*
        weak var weakSelf = self
    
        UIAlertController.alertSheet(title: "提示", message: "修改头像", buttons: ["相机","相册"], dismiss: { (btnIndex) in
            print(btnIndex);
            //  相册，拍照
            if let action = weakSelf?.actionHandler {
                action(btnIndex)
            }

            
        }) {
            print("b")
        }
        */
       
    }
}
