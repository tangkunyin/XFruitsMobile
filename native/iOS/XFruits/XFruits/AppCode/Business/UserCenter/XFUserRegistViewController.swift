//
//  XFUserRegistViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import MBProgressHUD

class XFUserRegistViewController: XFBaseSubViewController {
    
    var brandImageView:UIImageView? // 品牌logo
    var mobileTextField:UITextField!  // 手机号
    var validateTextField:UITextField! // 图片验证码
    var codeImageView:UIImageView? // 验证码图片
    
    var nextStepBtn:UIButton?  //下一步按钮
    var backToLoginBtn:UIButton? // 已有帐号去登录
    var userProtocalBtn:UIButton? // 用户协议
    var privacyBtn:UIButton? // 隐私政策
    
    var captchaImgString:NSString?  // 图片验证码
    var uniqueCodeString:NSString?  //唯一吗
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册"
        // 品牌logo
        self.brandImageView = UIImageView.init(image: UIImage.imageWithNamed("logo"))
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
        self.mobileTextField?.layer.borderColor = XFConstants.Color.pinkishGrey.cgColor
        self.mobileTextField?.layer.borderWidth = 0.5
        self.mobileTextField?.layer.cornerRadius = 10
        self.mobileTextField?.layer.sublayerTransform = CATransform3DMakeTranslation(10, 2, 0);
        self.mobileTextField?.attributedPlaceholder = NSAttributedString(string: "请输入手机号码", attributes: [NSForegroundColorAttributeName:colorWithRGB(204, g: 204, b: 204),NSFontAttributeName:UIFont.systemFont(ofSize: 14)])
        self.mobileTextField?.snp.makeConstraints({ (make) in
            
            make.top.equalTo((self.brandImageView?.snp.bottom)!).offset(15)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.height.equalTo(40)
            
        })
        
        // 图片验证码
        self.validateTextField = UITextField()
        self.view.addSubview(self.validateTextField!)
        self.validateTextField?.layer.borderColor = XFConstants.Color.pinkishGrey.cgColor
        self.validateTextField?.layer.borderWidth = 0.5
        self.validateTextField?.layer.cornerRadius = 10
        self.validateTextField?.layer.sublayerTransform = CATransform3DMakeTranslation(10, 2, 0);
        
        self.validateTextField?.attributedPlaceholder = NSAttributedString(string: "图片验证码", attributes: [NSForegroundColorAttributeName:colorWithRGB(204, g: 204, b: 204),NSFontAttributeName:UIFont.systemFont(ofSize: 14)])
        
        self.validateTextField?.snp.makeConstraints({ (make) in
            
            make.top.equalTo((self.mobileTextField?.snp.bottom)!).offset(22)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-XFConstants.UI.deviceWidth/2)
            make.height.equalTo(40)
            
        })
        
        // 验证码图片
        self.codeImageView = UIImageView.init()
        self.view.addSubview(self.codeImageView!)
        self.codeImageView?.snp.makeConstraints({ (make) in
            
            make.top.equalTo((self.mobileTextField?.snp.bottom)!).offset(22)
            make.left.equalTo(self.view).offset(XFConstants.UI.deviceWidth/2+20)
            make.right.equalTo(self.view).offset(-30)
            make.height.equalTo(40)
            
        })
        
        // 下一步按钮
        self.nextStepBtn = UIButton.init(type: .custom)
        self.nextStepBtn?.setTitle("下一步", for: .normal)
        self.nextStepBtn?.backgroundColor = XFConstants.Color.salmon
        self.nextStepBtn?.titleLabel?.textColor = UIColor.white
        self.view.addSubview(self.nextStepBtn!)
        self.nextStepBtn?.layer.cornerRadius = 15
        self.nextStepBtn?.layer.masksToBounds = true
        self.nextStepBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.validateTextField?.snp.bottom)!).offset(20)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.height.equalTo(40)
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
            make.top.equalTo((self.nextStepBtn?.snp.bottom)!).offset(22)
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
        self.privacyBtn?.setTitleColor(colorWithRGB(153, g: 153, b: 153), for: .normal)
        self.privacyBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
        
        self.privacyBtn?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self.view).offset(-20)
            make.left.equalTo(XFConstants.UI.deviceWidth/2)
            make.width.equalTo(100)
            make.height.equalTo(20)
        })
        self.privacyBtn?.addTarget(self, action: #selector(backToLoginVC(sender:)), for:.touchUpInside)
        
        // 获取图片验证码
        getImageVertifyCode()
        
    }
    
    
    // 获取图片验证码
    func getImageVertifyCode(){
        // 获取验证码请求测试
        XFCommonService().getVerifyImage { (data) in
            dPrint((data as! XFVerifyImage).captchaImg)
            self.captchaImgString = (data as! XFVerifyImage).captchaImg as NSString
            self.uniqueCodeString =  (data as! XFVerifyImage).uniqueCode as NSString
            
            self.codeImageView?.image = self.base64StringToUIImage(base64String: self.captchaImgString! as String)
            
        }
        
    }
    
    // 传入base64的字符串，可以是没有经过修改的转换成的以data开头的，也可以是base64的内容字符串，然后转换成UIImage
    func base64StringToUIImage(base64String:String)->UIImage? {
        var str = base64String
        
        // 1、判断用户传过来的base64的字符串是否是以data开口的，如果是以data开头的，那么就获取字符串中的base代码，然后在转换，如果不是以data开头的，那么就直接转换
        if str.hasPrefix("data:image") {
            guard let newBase64String = str.components(separatedBy: ",").last else {
                return nil
            }
            str = newBase64String
        }
        // 2、将处理好的base64String代码转换成NSData
        guard let imgNSData = NSData(base64Encoded: str, options: NSData.Base64DecodingOptions()) else {
            return nil
        }
        // 3、将NSData的图片，转换成UIImage
        guard let codeImage = UIImage(data: imgNSData as Data) else {
            return nil
        }
        return codeImage
    }
    
    
    // 返回登录页面
    func backToLoginVC(sender:UIButton?) {
        dPrint("eyes")
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    // 点击下一步触发的事件
    func nextStepToSecondRegistPageVC(sender:UIButton?) {
//        let code:String! =  self.validateTextField.text
//        let phone:String! = self.mobileTextField.text
        
        guard let phone:String = self.mobileTextField.text else {
            MBProgressHUD.showError("手机号不能为空")
            return
        }

        guard let code:String = self.validateTextField.text else {
            MBProgressHUD.showError("手机号不能为空")
            return
        }
        
        let para:[String:String]  = ["uniqueCode":self.uniqueCodeString! as String,"code":code  ,"phone":phone]
        
        
        dPrint(para)
        
        weak var weakSelf = self
        
        
        XFCommonService().vertifyImageCodeAndSendMessageCode(params: para) { (data) in
            dPrint(data)
            if data as! Bool {
                dPrint("返回成功，跳转到注册下一步页面")
                let secondRegistVC = XFUserRegistSecondPageViewController()
                secondRegistVC.para  = para as NSDictionary
                weakSelf?.show(secondRegistVC, sender: weakSelf)
            }
        }
    }
}

