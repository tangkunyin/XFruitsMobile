//
//  XFAddAddressViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import MBProgressHUD

class XFAddAddressViewController: XFBaseSubViewController    {
    
    var editStyle: Int?  // 0 为增加模式，1为编辑模式。2为查看模式
    var leftTipArray:NSArray? // 左侧提示
    var addressSigleEdit:XFAddress?  // 从上个界面传过来，需要编辑的地址
    
    lazy var editAddressView:XFEditMyAddressView = {
        let editAddressView = XFEditMyAddressView.init(frame: CGRect.zero)
        return editAddressView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if editStyle == 0 {
            self.title = "新增地址"
        }
            
        else if editStyle == 1 {
            self.title = "编辑地址"
            editAddressView.setMyAddress(address: addressSigleEdit!)
        }
        
        
        self.view.addSubview(editAddressView)
        
        editAddressView.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        })
        
        // 导航栏右侧保存按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "保存", style: .plain, target: self, action: #selector(saveAddress(sender:)))
        
        
    }
    
    // 导航栏右侧按钮-保存-触发的事件
    func saveAddress(sender:UIButton?) {
        dPrint("save")
        
        weak var weakSelf = self
        
        guard let addressDesc = editAddressView.addressDescTextView.text ,addressDesc != "" else {
            MBProgressHUD.showError("详细地址不能为空")
            return
        }
        
        guard let cellPhone = editAddressView.mobileInput.text , cellPhone != "" else {
            MBProgressHUD.showError("手机号码不能为空")
            return
        }
        
        guard let recipient = editAddressView.receiveInput.text ,recipient != "" else {
            MBProgressHUD.showError("收货人不能为空")
            return
        }
        
        
        if editStyle == 0 {
            
            let addressDict:[String:String]  = ["code":"110101",
                                                "address":addressDesc,
                                                "recipient":recipient,
                                                "cellPhone":cellPhone,
                                                "isDefault":"1",
                                                "label":"老婆婆家"]
            
            XFCommonService().addAddress(params: addressDict) { (data) in
                dPrint(data)
                weakSelf!.navigationController?.popViewController(animated: true)
            }
            
        }
        else if editStyle == 1 {
            
            var addressModify = XFAddress()
            
            addressModify.id =  addressSigleEdit?.id
            addressModify.districtCode  = "110101"
            addressModify.address  = addressDesc
            addressModify.recipient = recipient
            addressModify.cellPhone = cellPhone
            addressModify.isDefault = "1"
            addressModify.label = "自己家"
            let addressId:String = String(addressSigleEdit!.id)
            
            
            let addressDict:[String:String]  = ["id":addressId,
                                                "address":addressModify.address!,
                                                "recipient":addressModify.recipient!,
                                                "cellPhone": addressModify.cellPhone! ,
                                                "isDefault":addressModify.isDefault!,
                                                "label":addressModify.label!,
                                                "code":addressModify.districtCode!]
            print(addressDict)
            
            XFCommonService().modifyAddress(params: addressDict){ (data) in
                dPrint(data)
                weakSelf!.navigationController?.popViewController(animated: true)
            }
            
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
