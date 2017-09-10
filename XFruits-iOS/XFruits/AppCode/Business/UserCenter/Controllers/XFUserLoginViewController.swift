//
//  XFUserLoginViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
// 登录

import UIKit

class XFUserLoginViewController: XFBaseSubViewController {
    
    // 品牌logo
    lazy var brandImageView:UIImageView = {
        let brandImageView = UIImageView.init(image: UIImage.imageWithNamed("logo"))
        return brandImageView
    }()
    
     // 手机号
    lazy var mobileTextField:UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.layer.borderColor = XFConstants.Color.pinkishGrey.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.keyboardType = .numberPad
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 2, 0);
        let attr = [NSForegroundColorAttributeName:XFConstants.Color.pinkishGrey,
                    NSFontAttributeName:XFConstants.Font.pfn14]
        textField.attributedPlaceholder = NSAttributedString(string: "请输入手机号码", attributes:attr)
        return textField
    }()
    
    lazy var passwordTextField:UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.isSecureTextEntry  = true
        textField.layer.borderColor = XFConstants.Color.pinkishGrey.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 2, 0);
        let attr = [NSForegroundColorAttributeName:XFConstants.Color.pinkishGrey,
                    NSFontAttributeName:XFConstants.Font.pfn14]
        textField.attributedPlaceholder = NSAttributedString(string: "请输入密码", attributes: attr)
        textField.returnKeyType = .done
        return textField;
    }()
    
    lazy var pwdSecurityBtn:UIButton = {
        let btn = UIButton.init(frame:CGRect.init(x: 0, y:0, width: 22, height:22))
        btn.setImage(UIImage.imageWithNamed("eye"), for: .normal)
        btn.addTarget(self, action: #selector(securityEyeClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var loginBtn:UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("登 录", for: .normal)
        btn.backgroundColor = XFConstants.Color.salmon
        btn.titleLabel?.textColor = UIColor.white
        btn.layer.cornerRadius = 20
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(toLogin), for:.touchUpInside)
        return btn
    }()
    
    lazy var forgetPwdBtn:UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("忘记密码", for: .normal)
        btn.backgroundColor = UIColor.white
        btn.setTitleColor(colorWithRGB(153, g: 153, b: 153), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(forgetPassword), for:.touchUpInside)
        return btn
    }()
    
    lazy var registAccount:UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("注册帐号", for: .normal)
        btn.backgroundColor = UIColor.white
        btn.setTitleColor(colorWithRGB(153, g: 153, b: 153), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(createAccount), for:.touchUpInside)
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        
        self.view.addSubview(self.brandImageView)
        self.view.addSubview(self.mobileTextField)
        self.view.addSubview(self.passwordTextField)
        self.view.addSubview(self.pwdSecurityBtn)
        self.view.addSubview(self.loginBtn)
        self.view.addSubview(self.forgetPwdBtn)
        self.view.addSubview(self.registAccount)
        
        brandImageView.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view).offset(80)
            make.width.equalTo(92)
            make.height.equalTo(100)
            make.centerX.equalTo(self.view)
        })
        mobileTextField.snp.makeConstraints({ (make) in
            make.top.equalTo(self.brandImageView.snp.bottom).offset(20)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.height.equalTo(40)
        })
        passwordTextField.snp.makeConstraints({ (make) in
            make.top.equalTo(self.mobileTextField.snp.bottom).offset(20)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.height.equalTo(40)
        })
        pwdSecurityBtn.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.passwordTextField)
            make.right.equalTo(self.passwordTextField.snp.right).offset(-20)
            make.width.height.equalTo(22)
        })
        
        loginBtn.snp.makeConstraints({ (make) in
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(20)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.height.equalTo(40)
        })
        forgetPwdBtn.snp.makeConstraints({ (make) in
            make.top.equalTo(self.loginBtn.snp.bottom).offset(20)
            make.left.equalTo(self.view).offset(20)
            make.width.equalTo(75)
            make.height.equalTo(20)
        })
        registAccount.snp.makeConstraints({ (make) in
            make.top.equalTo(self.loginBtn.snp.bottom).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.width.equalTo(75)
            make.height.equalTo(20)
        })
        
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(disMissKeyboard)))
    }
    
    @objc func securityEyeClick() {
        self.passwordTextField.isSecureTextEntry = !self.passwordTextField.isSecureTextEntry
    }
    
    @objc func createAccount() {
        let registVC = XFUserRegistViewController()
        navigationController?.pushViewController(registVC, animated: true)
    }
    
    @objc func toLogin(){
        weak var weakSelf = self
        guard let phone = mobileTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            showError("手机号不能为空")
            return
        }
        guard let password = passwordTextField.text else {
            showError("密码不能为空")
            return
        }
        guard  isPhoneNumber(phoneNumber: phone) == true else{
            showError("请输入合法的手机号")
            return
        }
        let loginData = ["phone":phone,"password":password]
        XFCommonService().login(params: loginData) { (data) in
            let data = data as! XFUser
            XFUserGlobal.shared.signIn(user: data)
            if XFUserGlobal.shared.isLogin {
                dPrint("用户已登录")
                dPrint("Token is: \(XFUserGlobal.shared.token!)")
            }
            weakSelf?.backToParentController()
        }
    }
    
    @objc fileprivate func forgetPassword(){
        showSuccess("请取消登录后，联系客服处理")
    }
    
    @objc fileprivate func disMissKeyboard(){
        mobileTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}

extension XFUserLoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        disMissKeyboard()
        return true
    }
}

