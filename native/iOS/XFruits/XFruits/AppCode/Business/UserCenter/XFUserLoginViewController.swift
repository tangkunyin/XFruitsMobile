//
//  XFUserLoginViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
// 登录

import UIKit
import MBProgressHUD

class XFUserLoginViewController: XFBaseSubViewController {
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
        self.title = "登录"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "取消", style: .plain, target: self, action: #selector(cancelLogin))
        
        // 背景图（预备）
        //        self.backgroudImageView = UIImageView.init(image: UIImage.imageWithNamed("level"))
        //        self.view.addSubview(self.backgroudImageView!)
        //
        //        self.brandImageView?.snp.makeConstraints({ (make) in
        //            // 屏幕大小
        //            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        //        })
        
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
        self.mobileTextField?.attributedPlaceholder = NSAttributedString(string: "请输入手机号码", attributes: [NSForegroundColorAttributeName:XFConstants.Color.pinkishGrey,NSFontAttributeName:UIFont.systemFont(ofSize: 14)])
        self.mobileTextField?.snp.makeConstraints({ (make) in
            
            make.top.equalTo((self.brandImageView?.snp.bottom)!).offset(20)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.height.equalTo(40)
        })
        
        
        // 密码
        self.passwordTextField = UITextField()
        self.view.addSubview(self.passwordTextField!)
        
        self.passwordTextField?.isSecureTextEntry  = true
        self.passwordTextField?.layer.borderColor = XFConstants.Color.pinkishGrey.cgColor
        self.passwordTextField?.layer.borderWidth = 0.5
        self.passwordTextField?.layer.cornerRadius = 10
        self.passwordTextField?.layer.sublayerTransform = CATransform3DMakeTranslation(10, 2, 0);
        
        self.passwordTextField?.attributedPlaceholder = NSAttributedString(string: "请输入密码", attributes: [NSForegroundColorAttributeName:XFConstants.Color.pinkishGrey,NSFontAttributeName:UIFont.systemFont(ofSize: 14)])
        self.passwordTextField?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.mobileTextField?.snp.bottom)!).offset(20)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.height.equalTo(40)
        })
        
        
        // test
        self.mobileTextField?.text = "18658054127"
        self.passwordTextField?.text = "123456"
        
        self.pwdSecurityBtn = UIButton.init(frame:CGRect.init(x: 0, y:0, width: 22, height:22))
        self.pwdSecurityBtn?.setImage(UIImage.imageWithNamed("eye"), for: .normal)
        self.view?.addSubview(self.pwdSecurityBtn!)
        
        self.pwdSecurityBtn?.addTarget(self, action: #selector(securityEyeClick(sender:)), for: .touchUpInside)
        self.pwdSecurityBtn?.snp.makeConstraints({ (make) in
            
            make.centerY.equalTo(self.passwordTextField!)
            make.right.equalTo((self.passwordTextField?.snp.right)!).offset(-20)
            make.width.height.equalTo(22)
        })
        
        
        // 登录按钮
        self.loginBtn = UIButton.init(type: .custom)
        self.loginBtn?.setTitle("登录", for: .normal)
        self.loginBtn?.backgroundColor = XFConstants.Color.salmon
        self.loginBtn?.titleLabel?.textColor = UIColor.white
        self.view.addSubview(self.loginBtn!)
        self.loginBtn?.layer.cornerRadius = 20
        self.loginBtn?.layer.masksToBounds = true
        self.loginBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.passwordTextField?.snp.bottom)!).offset(20)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.height.equalTo(40)
        })
        self.loginBtn?.addTarget(self, action: #selector(xfruiltLogin(sender:)), for:.touchUpInside)
        
        
        
        // 忘记密码
        self.forgetPwdBtn = UIButton.init(type: .custom)
        self.forgetPwdBtn?.setTitle("忘记密码", for: .normal)
        self.view.addSubview(self.forgetPwdBtn!)
        self.forgetPwdBtn?.backgroundColor = UIColor.white
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
        
        if (self.passwordTextField?.isSecureTextEntry)! {
            self.passwordTextField?.isSecureTextEntry  = false
        }
        else{
            self.passwordTextField?.isSecureTextEntry  = true
            
        }
    }
    
    
    func createAccount(sender:UIButton?) {
        dPrint("createAccount")
        let registVC = XFUserRegistViewController()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.show(registVC, sender: self)
        
    }
    
    func xfruiltLogin(sender:UIButton?){
        dPrint("login")
        
        weak var weakSelf = self
        
        guard let phone = mobileTextField?.text else {
            MBProgressHUD.showError("手机号不能为空")
            return
        }
        
        guard let password = passwordTextField?.text else {
            MBProgressHUD.showError("密码不能为空")
            return
        }
        
        let loginData = ["phone":phone,"password":password]
        XFCommonService().login(params: loginData) { (data) in
            dPrint(data)
            let data = data as! XFUser

//             // 保存
//            let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
//            let filePath = path.appendingPathComponent("user.archive")  // 这个后缀要不要改
//            let cachedSuccess   = NSKeyedArchiver.archiveRootObject(data.toJSON()!, toFile: filePath)
//            print(cachedSuccess)
//            
//            // 读取
//            let cachedCotent = NSKeyedUnarchiver.unarchiveObject(withFile: filePath)
//            print(cachedCotent!)
            
            
            // =========== 试试用工具类缓存会不会更优雅！！！
            XFUserGlobal.shared.signIn(user: data)
            if XFUserGlobal.shared.isLogin {
                dPrint("用户已登录")
                dPrint("Token is: \(XFUserGlobal.shared.token!)")
               
            }
            // 试试用工具类缓存会不会更优雅！！！ =========== 
            
            
            
            dPrint("登录成功")
            weakSelf!.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func cancelLogin(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

