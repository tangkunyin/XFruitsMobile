//
//  XFruitsUserLoginViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/4/9.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
// 登录

import UIKit

class XFruitsUserLoginViewController: XFruitsBaseSubViewController {
    var backgroudImageView:UIImageView? // 背景图
    var brandImageView:UIImageView? // 品牌logo
    
    var mobileTextField:UITextField?  // 手机号
    var passwordTextField:UITextField? // 密码
    
    var pwdSecurityBtn:UIButton?  //密码眼睛

    var loginBtn:UIButton?  //登录按钮
    var forgetPwdBtn:UIButton? // 忘记密码
    var registAccount:UIButton? // 注册用户
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = UIColor.white
        
        // 背景图（预备）
//        self.backgroudImageView = UIImageView.init(image: UIImage.imageWithNamed("level"))
//        self.view.addSubview(self.backgroudImageView!)
//        
//        self.brandImageView?.snp.makeConstraints({ (make) in
//            // 屏幕大小
//            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
//        })
        
        // 品牌logo
        self.brandImageView = UIImageView.init(image: UIImage.imageWithNamed("level"))
        self.view.addSubview(self.brandImageView!)
        
        self.brandImageView?.snp.makeConstraints({ (make) in
            // 距离顶部110,宽92，高100，居中
            make.top.equalTo(self.view).offset(110)
            make.width.equalTo(92)
            make.height.equalTo(100)
            make.centerX.equalTo(self.view)
            
        })
        
        
        // 手机号
        self.mobileTextField = UITextField()
        self.view.addSubview(self.mobileTextField!)
        self.mobileTextField?.attributedPlaceholder = NSAttributedString(string: "请输入手机号码", attributes: [NSForegroundColorAttributeName:colorWithRGB(204, g: 204, b: 204),NSFontAttributeName:UIFont.systemFont(ofSize: 14)])
        self.mobileTextField?.snp.makeConstraints({ (make) in
           
            make.top.equalTo((self.brandImageView?.snp.bottom)!).offset(30)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
        })
        
        
        // 密码
        self.passwordTextField = UITextField()
        self.view.addSubview(self.passwordTextField!)
        
        self.passwordTextField?.isSecureTextEntry  = true
        
        self.passwordTextField?.attributedPlaceholder = NSAttributedString(string: "请输入密码", attributes: [NSForegroundColorAttributeName:colorWithRGB(204, g: 204, b: 204),NSFontAttributeName:UIFont.systemFont(ofSize: 14)]) //NSAttributedString(string:"请输入密码",attributes:[NSForegroundColorAttributeName: UIColor.blackColor])
        self.passwordTextField?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.mobileTextField?.snp.bottom)!).offset(20)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
        })
        
       
        self.pwdSecurityBtn = UIButton.init(type:.custom)
        self.pwdSecurityBtn?.setImage(UIImage.imageWithNamed("level"), for: .normal)

        self.passwordTextField?.rightView  = pwdSecurityBtn
        self.passwordTextField?.rightViewMode = .always;
//        self.pwdSecurityBtn?.addTarget(self, action:#sele,for:.touchUpInside)
        self.pwdSecurityBtn?.addTarget(self, action: #selector(securityEyeClick(sender:)), for: .touchUpInside)

        
       // 登录按钮
        self.loginBtn = UIButton.init(type: .custom)
        self.loginBtn?.setTitle("登录", for: .normal)
        self.loginBtn?.backgroundColor = colorWithRGB(255, g: 102, b: 102)
        self.loginBtn?.titleLabel?.textColor = UIColor.white
        self.view.addSubview(self.loginBtn!)
        self.loginBtn?.layer.cornerRadius = 15
        self.loginBtn?.layer.masksToBounds = true
        self.loginBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.passwordTextField?.snp.bottom)!).offset(20)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
        })
        
        // 忘记密码
        self.forgetPwdBtn = UIButton.init(type: .custom)
        self.forgetPwdBtn?.setTitle("忘记密码", for: .normal)
        self.view.addSubview(self.forgetPwdBtn!)
        self.forgetPwdBtn?.backgroundColor = UIColor.white
//        self.forgetPwdBtn?.titleLabel?.textColor = colorWithRGB(153, g: 153, b: 153)
        self.forgetPwdBtn?.setTitleColor(colorWithRGB(153, g: 153, b: 153), for: .normal)
        self.forgetPwdBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 14)

        
        self.forgetPwdBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.loginBtn?.snp.bottom)!).offset(20)
            make.left.equalTo(self.view).offset(20)
            make.width.equalTo(75)
            make.height.equalTo(20)
        })

        
        // 注册帐号
        self.registAccount = UIButton.init(type: .custom)
        self.registAccount?.setTitle("注册帐号", for: .normal)
        self.view.addSubview(self.registAccount!)
        self.registAccount?.backgroundColor = UIColor.white
        //        self.forgetPwdBtn?.titleLabel?.textColor = colorWithRGB(153, g: 153, b: 153)
        self.registAccount?.setTitleColor(colorWithRGB(153, g: 153, b: 153), for: .normal)
        self.registAccount?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        
        self.registAccount?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.loginBtn?.snp.bottom)!).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.width.equalTo(75)
            make.height.equalTo(20)
        })
        self.registAccount?.addTarget(self, action: #selector(createAccount(sender:)), for:.touchUpInside)

        
    }

    func securityEyeClick(sender:UIButton?) {
        dPrint("eyes")
        let btn = sender
        if (btn?.isSelected)! {
            self.passwordTextField?.isSecureTextEntry  = true
        }
        else{
            self.passwordTextField?.isSecureTextEntry  = false

        }
    }
    
    
    func createAccount(sender:UIButton?) {
        dPrint("createAccount")
        let registVC = XFruitsUserRegistViewController()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.show(registVC, sender: self)
        
    }
    
    

}
