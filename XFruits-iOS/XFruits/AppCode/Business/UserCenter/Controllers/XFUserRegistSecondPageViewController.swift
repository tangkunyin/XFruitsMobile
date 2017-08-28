//
//  XFUserRegistSecondPageViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import MBProgressHUD

class XFUserRegistSecondPageViewController: XFBaseSubViewController {
    
    var brandImageView:UIImageView? // 品牌logo
    
    var messageCodeTextField:UITextField?  // 验证码
    var passwordTextField:UITextField? // 密码
    var pwdSecurityBtn:UIButton?  //密码眼睛
    var registBtn:UIButton?  //注册按钮
    var sendCodeAgainBtn:UIButton?  // 重新发验证码按钮
    var para:NSDictionary? // 上个界面传过来的
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(disMissKeyboard)))

        // 品牌logo
        self.brandImageView = UIImageView.init(image: UIImage.imageWithNamed("logo"))
        self.view.addSubview(self.brandImageView!)
        self.brandImageView?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view).offset(80)
            make.width.equalTo(92)
            make.height.equalTo(100)
            make.centerX.equalTo(self.view)
        })
        
        
        // 短信验证码
        self.messageCodeTextField = UITextField()
        self.messageCodeTextField?.delegate = self
        self.view.addSubview(self.messageCodeTextField!)
        
        self.messageCodeTextField?.layer.borderColor = XFConstants.Color.pinkishGrey.cgColor
        self.messageCodeTextField?.layer.borderWidth = 0.5
        self.messageCodeTextField?.layer.cornerRadius = 10
        self.messageCodeTextField?.layer.sublayerTransform = CATransform3DMakeTranslation(10, 2, 0);
        
        self.messageCodeTextField?.attributedPlaceholder = NSAttributedString(string: "请输入短信验证码，5分钟有效", attributes: [NSAttributedStringKey.foregroundColor:colorWithRGB(204, g: 204, b: 204),NSAttributedStringKey.font:UIFont.systemFont(ofSize: 14)])
        self.messageCodeTextField?.snp.makeConstraints({ (make) in
            
            make.top.equalTo((self.brandImageView?.snp.bottom)!).offset(30)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.height.equalTo(40)
            
        })
        
        
        // 密码
        self.passwordTextField = UITextField()
        self.passwordTextField?.delegate = self
        self.view.addSubview(self.passwordTextField!)
        
        self.passwordTextField?.returnKeyType = .done
        self.passwordTextField?.isSecureTextEntry  = true
        self.passwordTextField?.layer.borderColor = XFConstants.Color.pinkishGrey.cgColor
        self.passwordTextField?.layer.borderWidth = 0.5
        self.passwordTextField?.layer.cornerRadius = 10
        self.passwordTextField?.layer.sublayerTransform = CATransform3DMakeTranslation(10, 2, 0);
        
        
        self.passwordTextField?.attributedPlaceholder = NSAttributedString(string: "请输入密码", attributes: [NSAttributedStringKey.foregroundColor:colorWithRGB(204, g: 204, b: 204),NSAttributedStringKey.font:UIFont.systemFont(ofSize: 14)]) //NSAttributedString(string:"请输入密码",attributes:[NSForegroundColorAttributeName: UIColor.blackColor])
        self.passwordTextField?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.messageCodeTextField?.snp.bottom)!).offset(20)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.height.equalTo(40)
            
        })
        
        // 注册按钮
        self.registBtn = UIButton.init(type: .custom)
        self.registBtn?.setTitle("注册", for: .normal)
        self.registBtn?.backgroundColor = XFConstants.Color.salmon
        self.registBtn?.titleLabel?.textColor = UIColor.white
        self.view.addSubview(self.registBtn!)
        self.registBtn?.layer.cornerRadius = 15
        self.registBtn?.layer.masksToBounds = true
        self.registBtn?.addTarget(self, action: #selector(gotoRegister(sender:)), for:.touchUpInside)
        
        self.registBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.passwordTextField?.snp.bottom)!).offset(20)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
        })
        
        // 重发验证码按钮
        self.sendCodeAgainBtn = UIButton.init(type: .custom)
        self.sendCodeAgainBtn?.setTitle("验证码没收到？再发一遍", for: .normal)
        
        self.sendCodeAgainBtn?.titleLabel?.textColor = colorWithRGB(153, g: 153, b: 153)
        self.view.addSubview(self.sendCodeAgainBtn!)
        self.sendCodeAgainBtn?.layer.cornerRadius = 15
        self.sendCodeAgainBtn?.layer.masksToBounds = true
        self.sendCodeAgainBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.registBtn?.snp.bottom)!).offset(20)
            //            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
        })
    
    }
    
    @objc func gotoRegister(sender:UIButton?) {
        
        guard let phone:String = para?["phone"] as? String else {
            MBProgressHUD.showError("手机号不能为空")
            return
        }
        guard let phoneCaptcha = messageCodeTextField?.text else {
            MBProgressHUD.showError("验证码不能为空")
            return
        }
        guard let password = passwordTextField?.text else {
            MBProgressHUD.showError("密码不能为空")
            return
        }
        
        let registPara:[String:String] = ["phone":phone,"password":password,"phoneCaptcha":phoneCaptcha]
        weak var weakSelf = self
        XFCommonService().register(params: registPara) { (data) in
            let data = data as! XFUser
            XFUserGlobal.shared.signIn(user: data)
            if XFUserGlobal.shared.isLogin {
                MBProgressHUD.showMessage("恭喜您，注册成功", completion: {
                    weakSelf!.dismiss(animated: true, completion: nil)
                })
            }
        }
    }
    
    @objc private func disMissKeyboard(){
        messageCodeTextField?.resignFirstResponder()
        passwordTextField?.resignFirstResponder()
    }

}

extension XFUserRegistSecondPageViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        disMissKeyboard()
        return true
    }
}
