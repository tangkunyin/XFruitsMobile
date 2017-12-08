//
//  XFAddressManageViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/11/11.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit

class XFAddressManageViewController: XFBaseSubViewController {

    var editStyle: Int?  // 0 为增加模式，1为编辑模式。2为查看模式
    var addressSigleEdit:XFAddress?  // 从上个界面传过来，编辑模式时候，需要编辑的地址
    
    lazy var editAddressView:XFEditMyAddressView = {
        let view = XFEditMyAddressView()
        weak var weakSelf = self
        view.actionHandler = { (address) in
            weakSelf?.saveAddress(address: address)
        }
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(editAddressView)
        editAddressView.snp.makeConstraints({ (make) in
            make.left.right.top.equalTo(view)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.bottom.equalTo(view)
            }
        })
        
        if editStyle == 0 {
            self.title = "新增地址"
        } else if editStyle == 1 {
            self.title = "编辑地址"
            editAddressView.setMyAddress(address: addressSigleEdit!)
        }
    }
    
    private func onAddressUpdate() {
        stopLoadding()
        backToParentController()
    }
    
    private func saveAddress(address :XFAddress) {
        weak var weakSelf = self
        var addressDict:[String:Any]  = ["code":address.districtCode, "address":address.address, "recipient":address.recipient,
                                         "cellPhone":address.cellPhone, "isDefault":address.isDefault, "label":address.label]
        loaddingWithMsg("操作中，请稍后...")
        if editStyle == 0 {  // 添加地址
            XFAddressService.addAddress(params: addressDict) { (data) in
                weakSelf?.onAddressUpdate()
            }
        } else if editStyle == 1 {  // 修改地址
            let addressId:String = addressSigleEdit!.id
            addressDict["id"] = addressId  // 编辑模式要多传一个地址id
            XFAddressService.modifyAddress(params: addressDict){ (data) in
                weakSelf?.onAddressUpdate()
            }
        }
    }

}
