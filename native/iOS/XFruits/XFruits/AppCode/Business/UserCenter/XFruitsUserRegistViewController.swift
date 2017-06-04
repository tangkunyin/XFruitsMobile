//
//  XFruitsUserRegistViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/4/9.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit

class XFruitsUserRegistViewController: XFruitsBaseSubViewController {

    var brandImageView:UIImageView? // 品牌logo
    var mobileTextField:UITextField?  // 手机号
    var validateTextField:UITextField? // 图片验证码
    var codeImageView:UIImageView? // 验证码图片
    
    var nextStepBtn:UIButton?  //下一步按钮
    var backToLoginBtn:UIButton? // 已有帐号去登录
    var userProtocalBtn:UIButton? // 用户协议
    var privacyBtn:UIButton? // 隐私政策
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

        // 手机号
        self.mobileTextField = UITextField()
        self.view.addSubview(self.mobileTextField!)
        self.mobileTextField?.attributedPlaceholder = NSAttributedString(string: "请输入手机号码", attributes: [NSForegroundColorAttributeName:colorWithRGB(204, g: 204, b: 204),NSFontAttributeName:UIFont.systemFont(ofSize: 14)])
        self.mobileTextField?.snp.makeConstraints({ (make) in
            
            make.top.equalTo((self.brandImageView?.snp.bottom)!).offset(30)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.height.equalTo(30)

        })
        
        // 图片验证码
        self.validateTextField = UITextField()
        self.view.addSubview(self.validateTextField!)
        self.validateTextField?.attributedPlaceholder = NSAttributedString(string: "图片验证码", attributes: [NSForegroundColorAttributeName:colorWithRGB(204, g: 204, b: 204),NSFontAttributeName:UIFont.systemFont(ofSize: 14)])
        
        self.validateTextField?.snp.makeConstraints({ (make) in
            
            make.top.equalTo((self.mobileTextField?.snp.bottom)!).offset(30)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-XFConstants.UI.deviceWidth/2)
            make.height.equalTo(30)

        })
        
        // 验证码图片
        self.codeImageView = UIImageView.init(image: UIImage.imageWithNamed("level"))
        self.view.addSubview(self.codeImageView!)
        self.codeImageView?.snp.makeConstraints({ (make) in
            
            make.top.equalTo((self.mobileTextField?.snp.bottom)!).offset(30)
            make.left.equalTo(self.view).offset(XFConstants.UI.deviceWidth/2+20)
            make.right.equalTo(self.view).offset(-30)
            make.height.equalTo(30)

        })
        
        // 下一步按钮
        self.nextStepBtn = UIButton.init(type: .custom)
        self.nextStepBtn?.setTitle("下一步", for: .normal)
        self.nextStepBtn?.backgroundColor = colorWithRGB(255, g: 102, b: 102)
        self.nextStepBtn?.titleLabel?.textColor = UIColor.white
        self.view.addSubview(self.nextStepBtn!)
        self.nextStepBtn?.layer.cornerRadius = 15
        self.nextStepBtn?.layer.masksToBounds = true
        self.nextStepBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.validateTextField?.snp.bottom)!).offset(20)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
        })
        self.nextStepBtn?.addTarget(self, action: #selector(nextStepToSecondRegistPageVC(sender:)), for:.touchUpInside)


        
        // 已有帐号，去登录
        self.backToLoginBtn = UIButton.init(type: .custom)
        self.backToLoginBtn?.setTitle("已有帐号？去登录", for: .normal)
        self.view.addSubview(self.backToLoginBtn!)
        self.backToLoginBtn?.backgroundColor = UIColor.white
        //        self.forgetPwdBtn?.titleLabel?.textColor = colorWithRGB(153, g: 153, b: 153)
        self.backToLoginBtn?.setTitleColor(colorWithRGB(153, g: 153, b: 153), for: .normal)
        self.backToLoginBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        
        self.backToLoginBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.nextStepBtn?.snp.bottom)!).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.width.equalTo(150)
            make.height.equalTo(20)
        })
        self.backToLoginBtn?.addTarget(self, action: #selector(backToLoginVC(sender:)), for:.touchUpInside)
        
        
        
        
        // 用户协议
        self.userProtocalBtn = UIButton.init(type: .custom)
        self.userProtocalBtn?.setTitle("用户协议", for: .normal)
        self.view.addSubview(self.userProtocalBtn!)
        self.userProtocalBtn?.backgroundColor = UIColor.white
        //        self.forgetPwdBtn?.titleLabel?.textColor = colorWithRGB(153, g: 153, b: 153)
        self.userProtocalBtn?.setTitleColor(colorWithRGB(153, g: 153, b: 153), for: .normal)
        self.userProtocalBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
        
        self.userProtocalBtn?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self.view).offset(-20)
            make.right.equalTo(-XFConstants.UI.deviceWidth/2)
            make.width.equalTo(100)
            make.height.equalTo(20)
        })
        self.userProtocalBtn?.addTarget(self, action: #selector(backToLoginVC(sender:)), for:.touchUpInside)
        
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
        self.privacyBtn?.addTarget(self, action: #selector(backToLoginVC(sender:)), for:.touchUpInside)
        

        
        
        
    }

    
    func backToLoginVC(sender:UIButton?) {
        dPrint("eyes")
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func nextStepToSecondRegistPageVC(sender:UIButton?) {
        dPrint("eyes")
        let secondRegistVC = XFruitsUserRegistSecondPageViewController()
        self.show(secondRegistVC, sender: self)
        
    }


}
