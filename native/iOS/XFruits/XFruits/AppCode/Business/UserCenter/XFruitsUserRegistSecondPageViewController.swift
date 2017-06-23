//
//  XFruitsUserRegistSecondPageViewController.swift
//  XFruits
//
//  Created by zhaojian on 5/16/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class XFruitsUserRegistSecondPageViewController: XFruitsBaseSubViewController {

    var brandImageView:UIImageView? // 品牌logo
    
    var messageCodeTextField:UITextField?  // 验证码
    var passwordTextField:UITextField? // 密码
    var pwdSecurityBtn:UIButton?  //密码眼睛
    var registBtn:UIButton?  //注册按钮
    var sendCodeAgainBtn:UIButton?  // 重新发验证码按钮
    
    var userProtocalBtn:UIButton? // 用户协议
    var privacyBtn:UIButton? // 隐私政策
    
    var para:NSDictionary? // 上个界面传过来的
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dPrint(para)
        
        
        self.view.backgroundColor = UIColor.white
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

        // 短信验证码
        self.messageCodeTextField = UITextField()
        self.view.addSubview(self.messageCodeTextField!)
        self.messageCodeTextField?.attributedPlaceholder = NSAttributedString(string: "请输入短信验证码，5分钟有效", attributes: [NSForegroundColorAttributeName:colorWithRGB(204, g: 204, b: 204),NSFontAttributeName:UIFont.systemFont(ofSize: 14)])
        self.messageCodeTextField?.snp.makeConstraints({ (make) in
            
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
            make.top.equalTo((self.messageCodeTextField?.snp.bottom)!).offset(20)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
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

        // 用户协议
        self.userProtocalBtn = UIButton.init(type: .custom)
        self.userProtocalBtn?.setTitle("用户协议", for: .normal)
        self.view.addSubview(self.userProtocalBtn!)
        self.userProtocalBtn?.backgroundColor = UIColor.white
        
        self.userProtocalBtn?.setTitleColor(colorWithRGB(153, g: 153, b: 153), for: .normal)
        self.userProtocalBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
        
        self.userProtocalBtn?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self.view).offset(-20)
            make.right.equalTo(-XFConstants.UI.deviceWidth/2)
            make.width.equalTo(100)
            make.height.equalTo(20)
        })
        self.userProtocalBtn?.addTarget(self, action: #selector(gotoPrivacyVC(sender:)), for:.touchUpInside)
        
        // 隐私政策
        self.privacyBtn = UIButton.init(type: .custom)
        self.privacyBtn?.setTitle("隐私政策", for: .normal)
        self.view.addSubview(self.privacyBtn!)
        self.privacyBtn?.backgroundColor = UIColor.white
        //        self.forgetPwdBtn?.titleLabel?.textColor = colorWithRGB(153, g: 153, b: 153)
        self.privacyBtn?.setTitleColor(colorWithRGB(153, g: 153, b: 153), for: .normal)
        self.privacyBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
        
        self.privacyBtn?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self.view).offset(-20)
            make.left.equalTo(XFConstants.UI.deviceWidth/2)
            make.width.equalTo(100)
            make.height.equalTo(20)
        })
        self.privacyBtn?.addTarget(self, action: #selector(gotoPrivacyVC(sender:)), for:.touchUpInside)
        
        
 
        
        
        // Do any additional setup after loading the view.
    }

    
    func gotoPrivacyVC(sender:UIButton?) {
        dPrint("eyes")
//        self.navigationController?.popViewController(animated: true)
        
    }
    
    // 
    func gotoRegister(sender:UIButton?) {
        dPrint("eyes")
//        {
//            "phone":"15701203653", //手机号
//            "password":"jj123456", //密码
//            "phoneCaptcha":"5812"  //短信验证码
//        }
        let phone:String  = self.para?["phone"] as! String
        
        let registPara:[String:String] = ["phone":phone,
                                          "password":(self.passwordTextField?.text)!,
                                          "phoneCaptcha":self.para?["code"] as! String]
        
        weak var weakSelf = self
        dPrint(registPara)
        XFruitsService().register(params: registPara) { (data) in
            dPrint(data)
            
            dPrint("注册成功")
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
