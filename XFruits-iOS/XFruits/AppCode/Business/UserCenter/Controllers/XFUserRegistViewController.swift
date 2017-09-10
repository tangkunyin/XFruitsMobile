//
//  XFUserRegistViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class XFUserRegistViewController: XFBaseSubViewController {
    
    //唯一吗
    var uniqueCodeString:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "手机验证"
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(disMissKeyboard)))
        
        // 获取图片验证码
        getImageVertifyCode()
        
        renderSubviews()
    }
    
    // 品牌logo
    lazy var brandImageView:UIImageView = {
        return UIImageView.init(image: UIImage.imageWithNamed("logo"))
    }()
    
    // 手机号
    lazy var mobileTextField:UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.layer.borderColor = XFConstants.Color.pinkishGrey.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.keyboardType = .numberPad
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 2, 0)
        textField.attributedPlaceholder = NSAttributedString(string: "请输入手机号码",
                                                             attributes:xfAttributes(fontColor: XFConstants.Color.pinkishGrey))
        return textField
    }()
    
    // 图片验证码
    lazy var validateTextField:UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.layer.borderColor = XFConstants.Color.pinkishGrey.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 2, 0);
        textField.returnKeyType = .done
        textField.attributedPlaceholder = NSAttributedString(string: "图片验证码",
                                                             attributes:xfAttributes(fontColor: XFConstants.Color.pinkishGrey))
        return textField
    }()
    
    // 验证码图片
    lazy var codeImageView:UIImageView = {
        return UIImageView.init()
    }()
    
    
    //下一步按钮
    lazy var nextStepBtn:UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("下一步", for: .normal)
        btn.backgroundColor = XFConstants.Color.salmon
        btn.titleLabel?.textColor = UIColor.white
        btn.layer.cornerRadius = 15
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(nextStepToSecondRegistPageVC(sender:)), for:.touchUpInside)
        return btn
    }()
    
    // 已有帐号去登录
    lazy var backToLoginBtn:UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("已有帐号？去登录", for: .normal)
        btn.backgroundColor = UIColor.white
        btn.setTitleColor(colorWithRGB(153, g: 153, b: 153), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(backToLoginVC(sender:)), for:.touchUpInside)
        return btn
    }()
    
    // 用户协议
    lazy var userProtocalBtn:UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("用户协议及隐私政策", for: .normal)
        btn.backgroundColor = UIColor.white
        btn.setTitleColor(colorWithRGB(153, g: 153, b: 153), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.addTarget(self, action: #selector(userProtocol), for:.touchUpInside)
        return btn
    }()
    
    private func renderSubviews() {
        // 品牌logo
        view.addSubview(brandImageView)
        brandImageView.snp.makeConstraints({ (make) in
            make.top.equalTo(view).offset(80)
            make.width.equalTo(92)
            make.height.equalTo(100)
            make.centerX.equalTo(view)
        })
        
        // 手机号
        view.addSubview(mobileTextField)
        mobileTextField.snp.makeConstraints({ (make) in
            make.top.equalTo(brandImageView.snp.bottom).offset(15)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(40)
        })
        
        // 图片验证码
        view.addSubview(validateTextField)
        validateTextField.snp.makeConstraints({ (make) in
            make.top.equalTo(mobileTextField.snp.bottom).offset(22)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-XFConstants.UI.deviceWidth/2)
            make.height.equalTo(40)
        })
        
        // 验证码图片
        view.addSubview(codeImageView)
        codeImageView.snp.makeConstraints({ (make) in
            make.top.equalTo(mobileTextField.snp.bottom).offset(22)
            make.left.equalTo(view).offset(XFConstants.UI.deviceWidth/2+20)
            make.right.equalTo(view).offset(-30)
            make.height.equalTo(40)
        })
        
        // 下一步按钮
        view.addSubview(nextStepBtn)
        nextStepBtn.snp.makeConstraints({ (make) in
            make.top.equalTo(validateTextField.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(40)
        })
        
        // 已有帐号，去登录
        view.addSubview(backToLoginBtn)
        backToLoginBtn.snp.makeConstraints({ (make) in
            make.top.equalTo(nextStepBtn.snp.bottom).offset(22)
            make.right.equalTo(view).offset(-20)
            make.width.equalTo(150)
            make.height.equalTo(20)
        })
        
        
        // 用户协议
        view.addSubview(userProtocalBtn)
        userProtocalBtn.snp.makeConstraints({ (make) in
            make.bottom.equalTo(view).offset(-30)
            make.size.equalTo(CGSize.init(width: 200, height: 20))
            make.centerX.equalTo(view)
        })
    }
    
    @objc fileprivate func userProtocol(){
        let webVC = XFWebViewController.init(withUrl: "https://www.10fruits.cn/privacy.html")
        webVC.title = "用户隐私政策"
        navigationController?.pushViewController(webVC, animated: true)
    }
    
    // 获取图片验证码
    func getImageVertifyCode(){
        // 获取验证码请求测试
        weak var weakSelf = self
        XFAuthService.getVerifyImage { (data) in
            if let verifyImage = data as? XFVerifyImage,
                let captchaImg = verifyImage.captchaImg,
                let uniqueCode = verifyImage.uniqueCode {
                weakSelf?.uniqueCodeString =  uniqueCode
                weakSelf?.codeImageView.image = UIImage.base64StringToUIImage(base64String: captchaImg)
            }
        }
    }
    
    // 返回登录页面
    @objc func backToLoginVC(sender:UIButton?) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // 点击下一步触发的事件
    @objc func nextStepToSecondRegistPageVC(sender:UIButton?) {
        
        guard let phone:String = self.mobileTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) , phone != "" else {
            showError("手机号不能为空")
            return
        }
        
        guard let code:String = self.validateTextField.text , code != "" else {
            showError("图片验证码不能为空")
            return
        }
        
        guard  isPhoneNumber(phoneNumber: phone) == true else {
            showError("请输入合法的手机号")
            return
        }
        
        weak var weakSelf = self
        let para:[String:String]  = ["uniqueCode": uniqueCodeString,"code": code ,"phone": phone]
        XFAuthService.vertifyImageCodeAndSendMessageCode(params: para) { (data) in
            if data is Bool, data as! Bool {
                let secondRegistVC = XFUserRegistSecondPageViewController()
                secondRegistVC.para  = para as NSDictionary
                weakSelf?.show(secondRegistVC, sender: weakSelf)
            }
        }
    }
    
    @objc fileprivate func disMissKeyboard(){
        mobileTextField.resignFirstResponder()
        validateTextField.resignFirstResponder()
    }
}

extension XFUserRegistViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        disMissKeyboard()
        return true
    }
}
