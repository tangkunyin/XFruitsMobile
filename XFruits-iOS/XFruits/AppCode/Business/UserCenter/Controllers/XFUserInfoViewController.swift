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
            make.right.bottom.equalTo(view).offset(-20)
            make.height.equalTo(45)
        }
        
        // 测试获取用户信息
        getUserInfo()
        
    }

    @objc fileprivate func onLoginOut(){
        XFUserGlobal.shared.signOff()
        backToParentController()
    }
    
    fileprivate func getUserInfo() {
        XFUseInfoService.getUserInfo { (data) in
           
//             let data = data as! XFUser
             print(data)
//            XFUserGlobal.shared.signIn(user: data)
//            let user = 
            
        }
    }
    
    fileprivate func updateUserInfo(params:XFParams) {
        
//        weak var weakSelf = self
//        let params:XFParams = ["username":"yijian1"]
//        {
//            "username":"吼吼",
//            "sex":1,
//            "email":"asdfasdf@qq.com",
//            "avatar": "http://sdfsdf.com/adsfas.jpg"
//        }
        XFUseInfoService.updateUserInfo(params: params) { (data) in
           
            if let resp = data as? NSNumber , resp == 1{
                print(data)
                MBProgressHUD.showSuccess("更新用户信息成功~")
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
                let params:XFParams = ["username":newNickname]
                weakSelf?.updateUserInfo(params: params)  // 发起更新用户信息请求
            })
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
 
        }
        else if type == LABEL_TAG.sex.rawValue{
            UIAlertController.alertSheet(title: "提示", message: "修改性别", buttons: ["男","女"], dismiss: { (btnIndex) in
                let sex:NSInteger =  btnIndex == 0 ? 0 : 1
                let params:XFParams = ["sex":sex]
                
                 weakSelf?.updateUserInfo(params: params)  // 发起更新用户信息请求
            }) {
                print("b")
            }

        }
        else if type == LABEL_TAG.changePwd.rawValue{
            
        }
        else if type == LABEL_TAG.signature.rawValue {
            let alert = UIAlertController.init(title: "提示", message: "修改个性签名", preferredStyle: .alert)
            alert.addTextField(configurationHandler: { (textField) in
                // print(textField.text)  // 是否回显昵称
            })
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "好的", style: .default, handler: {
                action in
//                let newNickname:String =  alert.textFields![0].text!
//                let params:XFParams = ["username":newNickname]
//                weakSelf?.updateUserInfo(params: params)  // 发起更新用户信息请求
            })
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
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
