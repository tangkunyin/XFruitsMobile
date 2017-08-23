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
    
    var addressSigleEdit:XFAddress?  // 从上个界面传过来，编辑模式时候，需要编辑的地址
    
    // 编辑视图
    lazy var editAddressView:XFEditMyAddressView = {
        let view = XFEditMyAddressView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(editAddressView)
        weak var weakSelf = self
        editAddressView.actionHandler = { (address) in
            weakSelf?.saveAddress(address: address)
        }
        editAddressView.snp.makeConstraints({ (make) in
            make.edges.equalTo(view).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        })
  
        if editStyle == 0 {
            self.title = "新增地址"
        } else if editStyle == 1 {
            self.title = "编辑地址"
            editAddressView.setMyAddress(address: addressSigleEdit!)
        }
    }
    
    // 导航栏右侧按钮-保存-触发的事件
    
     func saveAddress(address :XFAddress) {
        weak var weakSelf = self
        var addressDict:[String:Any]  = ["code":address.districtCode!.stringValue,
                                        "address":address.address,
                                        "recipient":address.recipient,
                                        "cellPhone":address.cellPhone,
                                        "isDefault":address.isDefault,
                                        "label":address.label ?? ""]
        if editStyle == 0 {  // 添加地址
            XFAddressService().addAddress(params: addressDict) { (data) in
                weakSelf!.backToParentController()
            }
        } else if editStyle == 1 {  // 修改地址
            let addressId:String = String(addressSigleEdit!.id)
            addressDict["id"] = addressId  // 编辑模式要多传一个地址id
            XFAddressService().modifyAddress(params: addressDict){ (data) in
                weakSelf!.backToParentController()
            }
        }
    }
    
}
