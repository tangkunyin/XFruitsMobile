//
//  XFUserInfoViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/8/20.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD

/// 用户信息、退出、头像上传
class XFUserInfoViewController: XFBaseSubViewController {
    
    lazy var loginOutBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("退出登录", for: .normal)
        btn.titleLabel?.font = XFConstants.Font.pfn16
        btn.setTitleColor(XFConstants.Color.salmon, for: .normal)
        btn.layer.cornerRadius = 6
        btn.layer.borderWidth = 1
        btn.layer.borderColor = XFConstants.Color.salmon.cgColor
        btn.addTarget(self, action: #selector(onLoginOut), for: .touchUpInside)
        return btn
    }()
    
    func imagePickerController() -> UIImagePickerController {
        let imagePickerController = UIImagePickerController.init()
        imagePickerController.delegate   = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        return imagePickerController
    }
    
    lazy var userInfoView :XFUserInfoView = {
        let view = XFUserInfoView()
        weak var weakSelf = self
        
        view.actionHandler = {(type:Int) -> Void in
            print(type)
            weakSelf?.selectEvent(type:type)  // view上的点击操作，触发不同类型的操作。
        }
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "个人资料"
        
        view.addSubview(userInfoView)
        userInfoView.snp.makeConstraints({ (make) in
            make.left.top.bottom.right.equalTo(view)
        })
        
        view.addSubview(loginOutBtn)
        loginOutBtn.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(45)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            } else {
                make.bottom.equalTo(view).offset(-20)
            }
        }
        
        // 测试获取用户信息
        getUserInfo()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc fileprivate func onLoginOut(){
        XFUserGlobal.shared.signOff()
        backToParentController()
    }
    
    fileprivate func getUserInfo() {
         weak var weakSelf = self
        XFUseInfoService.getUserInfo { (data) in
            if  let data:XFUser = data as? XFUser{
                print(data)
                XFUserGlobal.shared.signIn(user: data)
                weakSelf?.userInfoView.setUserInfo(data: data)
            }
        }
    }
    
    // 更新用户信息
    fileprivate func updateUserInfo(params:XFParams) {
        
        weak var weakSelf = self
        XFUseInfoService.updateUserInfo(params: params) { (data) in
            
            if let resp = data as? NSNumber , resp == 1{
//                print(data)
                MBProgressHUD.showSuccess("更新用户信息成功~")
                weakSelf?.getUserInfo()
            }
        }
    }
    
    
    func selectEvent(type:Int)  {
        weak var weakSelf = self
        
        if (type == 0){
           
            if (UIImagePickerController.isSourceTypeAvailable(.camera)){
                let imagePicker:UIImagePickerController = (self.imagePickerController())
                imagePicker.allowsEditing = true
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
            else{
                UIAlertController.alert(title: "提示", message: "该设备不支持相机")
            }
 
        }
        else if (type == 1){
           
            if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
                let imagePicker:UIImagePickerController = (self.imagePickerController())
                imagePicker.allowsEditing = true
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }
            else{
                UIAlertController.alert(title: "提示", message: "该设备不支持相册")
            }
 
        }
        else if type == LABEL_TAG.nickname.rawValue{
            let alert = UIAlertController.init(title: "提示", message: "修改昵称", preferredStyle: .alert)
            alert.addTextField(configurationHandler: { (textField) in
                // print(textField.text)  // 是否回显昵称
            })
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "好的", style: .default, handler: {
                action in
                let newNickname:String =  alert.textFields![0].text!
                guard weakSelf?.isEmpty(str: newNickname) == true else{
                    weakSelf?.showError("输入昵称不能为空")
                    return
                }
                
                let params:XFParams = ["username":newNickname]
                weakSelf?.updateUserInfo(params: params)  // 发起更新用户信息请求
            })
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            
        }
        else if type == LABEL_TAG.sex.rawValue{  // 1男 0女
            UIAlertController.alertSheet(title: "提示", message: "修改性别", buttons: ["男","女"], dismiss: { (btnIndex) in
                let sex:NSInteger =  btnIndex == 0 ? 1 : 0
                let params:XFParams = ["sex":sex]
                
                weakSelf?.updateUserInfo(params: params)  // 发起更新用户信息请求
            }) {
                print("b")
            }
            
        }
        else if type == LABEL_TAG.email.rawValue{
            let alert = UIAlertController.init(title: "提示", message: "修改邮箱", preferredStyle: .alert)
            alert.addTextField(configurationHandler: { (textField) in
                // print(textField.text)  // 是否回显昵称
            })
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "好的", style: .default, handler: {
                action in
                let email:String =  alert.textFields![0].text!
                guard weakSelf?.isEmpty(str: email) == true else{
                    weakSelf?.showError("输入邮箱不能为空")
                    return
                }
                guard weakSelf?.isEmail(str: email) == true else{
                    weakSelf?.showError("输入邮箱格式不对")
                    return
                }
                let params:XFParams = ["email":email]
                weakSelf?.updateUserInfo(params: params)  // 发起更新用户信息请求
            })
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        else if type == LABEL_TAG.signature.rawValue {
            let alert = UIAlertController.init(title: "提示", message: "修改个性签名", preferredStyle: .alert)
            alert.addTextField(configurationHandler: { (textField) in
                // print(textField.text)  // 是否回显昵称
            })
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "好的", style: .default, handler: {
                action in
            })
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func isEmpty(str:String) -> Bool{
        if str.count < 1 {
            return false
        }
        else{
            return true

        }
    }
    
    func isEmail(str:String) -> Bool{
        let predicateStr = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
        let predicate =  NSPredicate(format: "SELF MATCHES %@" ,predicateStr)
        if predicate.evaluate(with: str){
            return true
        }
        else{
            return false
        }
    }
}



extension XFUserInfoViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        print(info)
        self.dismiss(animated: true , completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        self.dismiss(animated: true , completion: nil)
        
    }
}
