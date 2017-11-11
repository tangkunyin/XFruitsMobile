//
//  XFDetailCommentView.swift
//  XFruits
//
//  Created by tangkunyin on 28/05/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import MBProgressHUD
import SnapKit

fileprivate let addrCategory = ["家","公司","学校","邻居","闺蜜","丈母娘家"]

/// 新增或编辑地址
class XFEditMyAddressView: UIView {
    
    var addressCodeToSave: String = "0" // 选中的 citycode
    var actionHandler: ((XFAddress) -> Void)?
    
    lazy var nameView: XFRowInputView = {
        let view = XFRowInputView.init(title: "姓 名", placeHolder: "这里填收货人姓名", tag: 0, delegate: self)
        return view
    }()
    
    lazy var phoneView: XFRowInputView = {
        let view = XFRowInputView.init(title: "电 话", placeHolder: "这里填收货人手机号", tag: 1, delegate: self)
        return view
    }()
    
    lazy var provinceView: XFRowInputView = {
        let view = XFRowInputView.init(title: "省 市", placeHolder: "点击这里选择省市区", tag: 2, delegate: self, inputEnable: false)
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(chooseAddress)))
        return view
    }()
    
    lazy var addressView: XFRowInputView = {
        let view = XFRowInputView.init(title: "详 址", placeHolder: "详细地址（具体到门牌号）", tag: 3, delegate: self)
        return view
    }()

    lazy var saveBtn :UIButton = {
        let saveBtn = UIButton(type: .custom)
        saveBtn.backgroundColor = UIColor.white
        saveBtn.setTitle("保 存", for: .normal)
        saveBtn.setTitleColor(XFConstants.Color.salmon, for: .normal)
        saveBtn.titleLabel?.font = XFConstants.Font.pfn16
        saveBtn.layer.cornerRadius = 6
        saveBtn.layer.borderWidth = 1
        saveBtn.layer.borderColor = XFConstants.Color.salmon.cgColor
        saveBtn.layer.masksToBounds = true
        saveBtn.addTarget(self, action: #selector(saveAddress), for: .touchUpInside)
        return saveBtn
    }()
    
    lazy var addrCateSizer: UISegmentedControl = {
        let segmente = UISegmentedControl(items: addrCategory)
        let normalAttributes = [NSAttributedStringKey.foregroundColor:XFConstants.Color.salmon,
                                NSAttributedStringKey.font:pfnFontWithSize(12)]
        let selectAttributes = [NSAttributedStringKey.foregroundColor:XFConstants.Color.white,
                                NSAttributedStringKey.font:pfnFontWithSize(12)]
        segmente.setTitleTextAttributes(normalAttributes, for: .normal)
        segmente.setTitleTextAttributes(selectAttributes, for: .selected)
        segmente.selectedSegmentIndex = 0
        segmente.apportionsSegmentWidthsByContent = true
        segmente.backgroundColor = XFConstants.Color.white
        segmente.tintColor = XFConstants.Color.salmon
        return segmente
    }()
    
    lazy var defaultChangeBtn:UIButton = {
        let btn = UIButton.buttonWithTitle("默认地址",
                                           image: "checkbox-empty",
                                           textColor: XFConstants.Color.darkGray,
                                           textFont: XFConstants.Font.pfn16,
                                           directionType: .left,
                                           chAlignment: .center,
                                           cvAlignment: .center,
                                           cEdgeInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
                                           span: 10,
                                           target: self,
                                           action: #selector(checkboxSelect(_:)))
        return btn
    }()
    
    lazy var addressPickerView: XFCityChooseView = {
        let pickerView = XFCityChooseView()
        weak var weakSelf = self
        pickerView.myClosure = { (provinceStr: String, cityStr: String , areaStr: String, code: Int) -> Void in
            if code != 0 {
                weakSelf?.addressCodeToSave = "\(code)"
                weakSelf?.provinceView.textInput.text = provinceStr + " " + cityStr + " " + areaStr
            }
        }
        return pickerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    //: 编辑模式，设置地址值
    func setMyAddress(address:XFAddress)  {
        addressCodeToSave = address.districtCode
        nameView.textInput.text = address.recipient
        phoneView.textInput.text = address.cellPhone
        provinceView.textInput.text = addressPickerView.loadDefaultAreaWithCityCode(cityCode: Int(address.districtCode) ?? 0)
        addressView.textInput.text = address.address
        // 判断默认选中哪个
        if !address.label.isEmpty {
            let array: NSArray = addrCategory as NSArray
            addrCateSizer.selectedSegmentIndex = array.index(of: address.label)
        }
        if(address.isDefault == 1){
            defaultChangeBtn.setImage(UIImage.imageWithNamed("check_box_select"), for: .normal)
            defaultChangeBtn.isSelected = true
        }
    }
    
    fileprivate func customInit(){
        backgroundColor = XFConstants.Color.commonBackground
        addSubview(nameView)
        addSubview(phoneView)
        addSubview(provinceView)
        addSubview(addressView)
        addSubview(saveBtn)
        addSubview(addrCateSizer)
        addSubview(defaultChangeBtn)
        addSubview(addressPickerView)
        nameView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(30)
            make.left.right.equalTo(self)
            make.height.equalTo(44)
        }
        phoneView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.height.equalTo(44)
            make.top.equalTo(nameView.snp.bottom).offset(1)
        }
        provinceView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.height.equalTo(44)
            make.top.equalTo(phoneView.snp.bottom).offset(1)
        }
        addressView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.height.equalTo(44)
            make.top.equalTo(provinceView.snp.bottom).offset(1)
        }
        
        addrCateSizer.snp.makeConstraints { (make) in
            make.top.equalTo(addressView.snp.bottom).offset(30)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(35)
        }
        
        defaultChangeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(addrCateSizer.snp.bottom).offset(20)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(30)
        }
        
        saveBtn.snp.makeConstraints({ (make) in
            make.height.equalTo(44)
            make.left.equalTo(self).offset(20)
            make.right.bottom.equalTo(self).offset(-20)
        })
        addressPickerView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self)
        }
    }
    
    @objc fileprivate func chooseAddress() {
        hideKeybord()
        addressPickerView.showPickerView()
        if let text = provinceView.textInput.text {
            addressPickerView.loadDefaultArea(defaultArea: text)
        }
    }

    @objc func saveAddress() {
        
        let recipient = nameView.textInput.text ?? ""
        let cellPhone = phoneView.textInput.text ?? ""
        let addressDesc = addressView.textInput.text ?? ""
        let isDefault = defaultChangeBtn.isSelected == true ? 1 : 0
        
        guard !recipient.isEmpty else {
            MBProgressHUD.showError("收货人不能为空")
            return
        }

        guard !cellPhone.isEmpty else {
            MBProgressHUD.showError("手机号码不能为空")
            return
        }

        guard  isPhoneNumber(phoneNumber: cellPhone) else {
            MBProgressHUD.showError("请输入合法的手机号")
            return
        }

        guard !addressDesc.isEmpty else {
            MBProgressHUD.showError("详细地址不能为空")
            return
        }

        let cityCode =  addressCodeToSave
        guard cityCode != "0" else {
            MBProgressHUD.showError("请选择省市区")
            return
        }

        var addressModify = XFAddress()
        addressModify.districtCode  = "\(cityCode)"
        addressModify.address  = addressDesc
        addressModify.recipient = recipient
        addressModify.cellPhone = cellPhone
        addressModify.isDefault = isDefault
        addressModify.label = addrCategory[addrCateSizer.selectedSegmentIndex]
        if let action = actionHandler {
            action(addressModify)
        }
    }
    
    @objc fileprivate func checkboxSelect(_ btn:UIButton){
        if (!btn.isSelected){
            btn.setImage(UIImage.imageWithNamed("check_box_select"), for: .normal)
            btn.isSelected = true
        } else {
            btn.setImage(UIImage.imageWithNamed("checkbox-empty"), for: .normal)
            btn.isSelected = false
        }
    }
    
    fileprivate func hideKeybord() {
        nameView.textInput.resignFirstResponder()
        phoneView.textInput.resignFirstResponder()
        addressView.textInput.resignFirstResponder()
    }
}

extension XFEditMyAddressView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
