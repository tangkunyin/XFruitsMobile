//
//  XFUserRegistSecondPageViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class XFUserRegistSecondPageViewController: XFBaseSubViewController {
    
    // 上个界面传过来的
    var para:NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch XFUserGlobal.shared.accountActionType {
            case 0:
                title = "确认注册"
            case 1:
                title = "重置密码"
                actionBtn.setTitle("重置", for: .normal)
            default:
                break;
        }

        renderSubViews()

        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(disMissKeyboard)))

    }
    
    // 此处返回需要到跟
    override func backToParentController() {
        backToRootViewController()
    }
    
    lazy var brandImageView:UIImageView = {
        return UIImageView.init(image: UIImage.imageWithNamed("logo"))
    }()
    
    // 验证码
    lazy var messageCodeTextField:UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.keyboardType = .numberPad
        textField.layer.borderColor = XFConstants.Color.pinkishGrey.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 2, 0)
        textField.attributedPlaceholder = NSAttributedString(string: "请输入短信验证码，5分钟有效",
                                                             attributes:xfAttributes(fontColor: XFConstants.Color.pinkishGrey))
        return textField
    }()
    
    // 密码
    lazy var passwordTextField:UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.returnKeyType = .done
        textField.isSecureTextEntry  = true
        textField.layer.borderColor = XFConstants.Color.pinkishGrey.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 2, 0)
        textField.attributedPlaceholder = NSAttributedString(string: "请输入密码，长度不得小于6位",
                                                             attributes:xfAttributes(fontColor: XFConstants.Color.pinkishGrey))
        return textField
    }()
    
    //注册按钮
    lazy var actionBtn:UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("注册", for: .normal)
        btn.backgroundColor = XFConstants.Color.salmon
        btn.titleLabel?.textColor = UIColor.white
        btn.layer.cornerRadius = 15
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(actionHandler(sender:)), for:.touchUpInside)
        return btn
    }()
    
    
    private func renderSubViews(){
        // 品牌logo
        view.addSubview(brandImageView)
        brandImageView.snp.makeConstraints({ (make) in
            make.top.equalTo(view).offset(80)
            make.width.equalTo(92)
            make.height.equalTo(100)
            make.centerX.equalTo(view)
        })
        
        // 短信验证码
        view.addSubview(messageCodeTextField)
        messageCodeTextField.snp.makeConstraints({ (make) in
            make.top.equalTo(brandImageView.snp.bottom).offset(30)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(40)
        })
        
        
        // 密码
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints({ (make) in
            make.top.equalTo(messageCodeTextField.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(40)
            
        })
        
        view.addSubview(actionBtn)
        actionBtn.snp.makeConstraints({ (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        })
        
    }
    
    @objc func actionHandler(sender:UIButton?) {
        
        guard let phone:String = para?["phone"] as? String else {
            showError("手机号不能为空")
            return
        }
        guard let phoneCaptcha = messageCodeTextField.text else {
            showError("验证码不能为空")
            return
        }
        guard let password = passwordTextField.text else {
            showError("密码不能为空")
            return
        }
        
        guard password.count >= 6 else {
            showError("密码不得小于6位")
            return
        }
        
        let params:[String:String] = ["phone":phone,"password":password,"phoneCaptcha":phoneCaptcha]
        switch XFUserGlobal.shared.accountActionType {
        case 0:
            doRegist(withParams: params)
        case 1:
            doResetPassword(withParams: params)
        default:
            break;
        }

    }
    
    private func doRegist(withParams params :[String:String]) {
        weak var weakSelf = self
        XFAuthService.register(params: params) { (data) in
            let data = data as! XFUser
            XFUserGlobal.shared.signIn(user: data)
            if XFUserGlobal.shared.isLogin {
                weakSelf?.showMessage("恭喜您，注册成功", completion: {
                    weakSelf?.backToRootViewController()
                })
            }
        }
    }
    
    private func doResetPassword(withParams params :[String:String]) {
        weak var weakSelf = self
        XFAuthService.resetPassword(params: params) { (success) in
            if let success = success as? Bool {
                weakSelf?.showMessage(success ? "密码重置成功" : "密码重置失败", completion: {
                    weakSelf?.backToRootViewController()
                })
            }
        }
    }
    
    @objc func disMissKeyboard(){
        messageCodeTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
}

extension XFUserRegistSecondPageViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        disMissKeyboard()
        return true
    }
}
