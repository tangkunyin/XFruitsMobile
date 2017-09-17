//
//  XFUserInfoViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/8/20.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit

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
        imagePickerController.delegate   = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        return imagePickerController
    }
    
    lazy var userInfoView :XFUserInfoView = {
       let view = XFUserInfoView()
        weak var weakSelf = self

        view.actionHandler = {(type:Int) -> Void in
            print(type)
            
            if (UIImagePickerController.isSourceTypeAvailable(.camera)){
                let imagePicker:UIImagePickerController = (weakSelf?.imagePickerController())!
                imagePicker.allowsEditing = true
                imagePicker.sourceType = .camera
                weakSelf?.present(imagePicker, animated: true, completion: nil)
            }
            else{
                UIAlertController.alertSheet(title: "提示", message: "没有打开相机权限", buttons: ["确定"], dismiss: { (btnIndex) in
                    
                }) {
                    
                }
            }
            
            
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
       
        
    }

    
    @objc fileprivate func onLoginOut(){
        XFUserGlobal.shared.signOff()
        backToParentController()
    }
    

}

extension XFUserInfoViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        print(info)
    }
    
  
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
    }
}
