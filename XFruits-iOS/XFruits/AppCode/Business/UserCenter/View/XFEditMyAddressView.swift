//
//  XFDetailCommentView.swift
//  XFruits
//
//  Created by tangkunyin on 28/05/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import MBProgressHUD

/// 新增或编辑地址
class XFEditMyAddressView: UIView {
    
    deinit {
        dPrint("XFEditMyAddressView....")
    }
   
    var selectCategoryBtn:UIButton? // 被选中的 button
    var addressCodeToSave:NSNumber = 0 // 选中的 citycode
    var defaultLabel : String? // 编辑类别时默认选中的字符串
    
    // 声明闭包
    var actionHandler: ((XFAddress) -> Void)?

    let defaultCategoryData = ["家","公司","学校"]
    
    lazy var leftTipReceiveLabel: UILabel = {
        let leftTipReceiveLabel = UILabel.init()
        leftTipReceiveLabel.text = "收货人"
        leftTipReceiveLabel.textColor = XFConstants.Color.darkGray
        leftTipReceiveLabel.font  = XFConstants.Font.pfn14
        leftTipReceiveLabel.textAlignment = NSTextAlignment.left
        return leftTipReceiveLabel
    }()
    
    
    lazy var receiveInput:UITextField = {
        let receiveInput = UITextField.init()
        receiveInput.placeholder = "这里填收货人姓名"
        receiveInput.textColor  = XFConstants.Color.darkGray
        receiveInput.font = XFConstants.Font.pfn14
        return receiveInput
        
    }()
    
    lazy var leftMobileLabel: UILabel = {
        // 联系电话
        let leftMobileLabel = UILabel.init()
        leftMobileLabel.text = "联系电话"
        leftMobileLabel.textColor = XFConstants.Color.darkGray
        leftMobileLabel.font  = XFConstants.Font.pfn14
        leftMobileLabel.textAlignment = NSTextAlignment.left
        return leftMobileLabel
    }()
    
    
    lazy var mobileInput :UITextField = {
        // 联系电话输入框
        let mobileInput:UITextField = UITextField.init()
        mobileInput.placeholder = "这里填收货人联系电话"
        mobileInput.textColor  = XFConstants.Color.darkGray
        mobileInput.keyboardType = .numberPad
        mobileInput.font = XFConstants.Font.pfn14
        return mobileInput
    }()
    
    lazy var leftAddressLabel: UILabel = {
        // 收货地址
        let leftAddressLabel = UILabel.init()
        leftAddressLabel.text = "收货地址"
        leftAddressLabel.textColor = XFConstants.Color.darkGray
        leftAddressLabel.font  = XFConstants.Font.pfn16
        leftAddressLabel.textAlignment = NSTextAlignment.left
        return leftAddressLabel
    }()
    
    lazy var addressChooseLabel:UILabel = {
        let addressChooseLabel  = UILabel.init()
        addressChooseLabel.textColor  = XFConstants.Color.darkGray
        addressChooseLabel.font = XFConstants.Font.pfn14
        addressChooseLabel.text = "点击选择收货地址"
        return addressChooseLabel
    }()
    
    // 收货地址透明按钮
    lazy var addressBtn: UIButton = {
        let addressBtn = UIButton.init()
        addressBtn.titleLabel?.font = XFConstants.Font.pfn14
        addressBtn.setTitleColor(XFConstants.Color.purpleyGrey, for: .normal)
        addressBtn.addTarget(self, action: #selector(chooseAddress(_:)), for: .touchUpInside)
        return addressBtn
    }()
    
    lazy var saveBtn :UIButton = {
        let saveBtn = UIButton.init(type: .custom)
        saveBtn.setTitle("保 存", for: .normal)
        saveBtn.setTitleColor(XFConstants.Color.salmon, for: .normal)
        saveBtn.titleLabel?.font = XFConstants.Font.pfn16
        saveBtn.layer.cornerRadius = 5
        saveBtn.layer.borderWidth = 1
        saveBtn.layer.borderColor = XFConstants.Color.salmon.cgColor
        saveBtn.layer.masksToBounds = true
        saveBtn.addTarget(self, action: #selector(saveAddress(sender:)), for: .touchUpInside)
        return saveBtn
    }()
    
    lazy var addressDescTextView:UITextView = {
        let descAddress = UITextView()
        descAddress.delegate = self
        descAddress.font = XFConstants.Font.pfn16
        descAddress.isScrollEnabled = false
        descAddress.returnKeyType = .done
        return descAddress
    }()
    
    lazy var categoryCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //每个Item之间最小的间距
        layout.minimumInteritemSpacing = 10
        //每行之间最小的间距
        layout.minimumLineSpacing = 10
        
        let categoryCollectionView = UICollectionView(frame:CGRect.zero,collectionViewLayout:layout)
        categoryCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        categoryCollectionView.dataSource = self;
        categoryCollectionView.delegate = self;
        categoryCollectionView.backgroundColor = UIColor.white
        return categoryCollectionView
    }()
    
    lazy var useAsDefaultAddressBtn:UIButton = {
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
    
    lazy var placeHolderLabel : UILabel  = {
        let placeHolderLabel = UILabel()
        placeHolderLabel.textColor = XFConstants.Color.darkGray
        placeHolderLabel.text = "详细地址（具体到门牌号）"
        placeHolderLabel.font = XFConstants.Font.pfn14
        return placeHolderLabel
    }()
    
    
    private func customInit(){
        
        // 收货人
        addSubview(leftTipReceiveLabel)
        leftTipReceiveLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(self.snp.top).offset(12)
            make.left.equalTo(self.snp.left).offset(13)
            make.width.equalTo(70)
            make.height.equalTo(19)
        })
        
        // 收货人输入框
        addSubview(receiveInput)
        receiveInput.snp.makeConstraints({ (make) in
            make.top.equalTo(self.snp.top).offset(12)
            make.left.equalTo(leftTipReceiveLabel.snp.right).offset(13)
            make.right.equalTo(self).offset(-13)
            make.height.equalTo(19)
        })
        
        addSubview(receiveInput)
        receiveInput.snp.makeConstraints({ (make) in
            make.top.equalTo(self.snp.top).offset(12)
            make.left.equalTo(leftTipReceiveLabel.snp.right).offset(13)
            make.right.equalTo(self.snp.right).offset(-13)
            make.height.equalTo(19)
        })
        
        
        let line1:UIView = createSeperateLine()
        // 第1个分割线
        self.addSubview(line1)
        
        line1.snp.makeConstraints { (make) in
            make.top.equalTo(leftTipReceiveLabel.snp.bottom).offset(10)
            make.height.equalTo(0.4)
            make.left.right.equalTo(self)
        }
        
        
        // 联系电话
        addSubview(leftMobileLabel)
        leftMobileLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(line1.snp.bottom).offset(12)
            make.left.equalTo(self.snp.left).offset(13)
            
            make.width.equalTo(70)
            make.height.equalTo(19)
        })
        
        // 联系电话输入框
        addSubview(mobileInput)
        mobileInput.snp.makeConstraints({ (make) in
            make.top.equalTo(line1.snp.bottom).offset(12)
            make.left.equalTo(leftMobileLabel.snp.right).offset(13)
            make.right.equalTo(self.snp.right).offset(-13)
            make.height.equalTo(19)
        })
        
        let line2:UIView = createSeperateLine()
        
        // 第2个分割线
        self.addSubview(line2)
        line2.snp.makeConstraints { (make) in
            make.top.equalTo(leftMobileLabel.snp.bottom).offset(10)
            make.height.equalTo(0.4)
            make.left.right.equalTo(self)
        }
        
        
        // 收货地址
        addSubview(leftAddressLabel)
        leftAddressLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(line2.snp.bottom).offset(12)
            make.left.equalTo(self.snp.left).offset(13)
            make.width.equalTo(70)
            make.height.equalTo(19)
        })
        
        
        // 收货地址内容
        addSubview(addressChooseLabel)
        addressChooseLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(line2.snp.bottom).offset(12)
            make.left.equalTo(leftMobileLabel.snp.right).offset(13)
            make.right.equalTo(self.snp.right).offset(-13)
            make.height.equalTo(19)
        })
        
        
        // 收货地址透明按钮
        addSubview( addressBtn)
        addressBtn.snp.makeConstraints({ (make) in
            make.top.equalTo(line2.snp.bottom).offset(0)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(45)
        })
        
        
        
        // 第3个分割线
        let line3:UIView = createSeperateLine()
        
        self.addSubview(line3)
        line3.snp.makeConstraints { (make) in
            make.top.equalTo(leftAddressLabel.snp.bottom).offset(10)
            make.height.equalTo(0.5)
            make.left.right.equalTo(self)
        }
        
        // 详细地址输入框
        self.addSubview(addressDescTextView)
        addressDescTextView.snp.makeConstraints({ (make) in
            make.top.equalTo(line3.snp.bottom).offset(12)
            make.left.equalTo(self.snp.left).offset(13)
            make.right.equalTo(self.snp.right).offset(13)
            make.height.equalTo(100)
        })
        
        // 添加占位的placeholder
        addressDescTextView.addSubview(placeHolderLabel)
        placeHolderLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(addressDescTextView.snp.top).offset(10)
            make.left.equalTo(self.snp.left).offset(15)
            make.right.equalTo(self.snp.right).offset(15)
            make.height.equalTo(14)
        })
        
        
        // 第4个分割线
        let line4:UIView = createSeperateLine()
        
        self.addSubview(line4)
        line4.snp.makeConstraints { (make) in
            make.top.equalTo(addressDescTextView.snp.bottom).offset(10)
            make.height.equalTo(0.5)
            make.left.right.equalTo(self)
        }
        
        // 地址分类
        self.addSubview(categoryCollectionView)
        categoryCollectionView.snp.makeConstraints({ (make) in
            make.top.equalTo(line4.snp.bottom).offset(15)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-5)
            make.height.equalTo(30)
        })
        // 默认地址按钮
        
        self.addSubview(useAsDefaultAddressBtn)
        useAsDefaultAddressBtn.snp.makeConstraints( { (make) in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(0)
            make.left.equalTo(self.snp.left).offset(5)
            make.right.equalTo(self.snp.right).offset(-5)
            make.height.equalTo(40)
        })
        
        self.addSubview(saveBtn)
        saveBtn.snp.makeConstraints({ (make) in
            make.height.equalTo(40)
            make.left.equalTo(self).offset(15)
            make.right.bottom.equalTo(self).offset(-10)
        })
    }
    
    // 编辑模式，设置地址值
    func setMyAddress(address:XFAddress)  {
        receiveInput.text = address.recipient
        mobileInput.text = address.cellPhone
        
        addressDescTextView.text = address.address
        if  addressDescTextView.text.characters.count > 0 {
            placeHolderLabel.text = ""
        }
        if(address.isDefault == 1){
            useAsDefaultAddressBtn.setImage(UIImage.imageWithNamed("check_box_select"), for: .normal)
            useAsDefaultAddressBtn.isSelected = true
        }
        let cityView = XFCityChooseView.init(frame: self.bounds)
        
        addressCodeToSave = address.districtCode!
        addressChooseLabel.text = cityView.loadDefaultAreaWithCityCode(cityCode: address.districtCode! )
        // 判断默认选中哪个
        defaultLabel = address.label
    }
    
    @objc private func chooseAddress(_ btn:UIButton){
        hideKeyboard()
        self.saveBtn.isHidden = true
        let cityView = XFCityChooseView.init(frame: self.bounds)
        weak var weakSelf = self
        if(weakSelf?.addressChooseLabel.text != nil ){
            cityView.loadDefaultArea(defaultArea: (weakSelf?.addressChooseLabel.text)!)
        }
        cityView.myClosure = { (provinceStr: String, cityStr: String , areaStr: String, addressCodeToSave: NSNumber) -> Void in
            if addressCodeToSave != 0 {
                weakSelf?.addressCodeToSave = addressCodeToSave
                weakSelf?.addressBtn.setTitle("", for: .normal)
                weakSelf?.addressChooseLabel.text = provinceStr + " " + cityStr + " " + areaStr
            }
            weakSelf?.saveBtn.isHidden = false
        }
        self.addSubview(cityView)
    }
    
    
    @objc func saveAddress(sender:UIButton?) {
        
        guard let recipient = receiveInput.text?.trimmingCharacters(in: .whitespacesAndNewlines), recipient != ""  else {
            MBProgressHUD.showError("收货人不能为空")
            return
        }
        
        guard let cellPhone = mobileInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) , cellPhone != "" else {
            MBProgressHUD.showError("手机号码不能为空")
            return
        }
        
        guard  isPhoneNumber(phoneNumber: cellPhone) == true else{
            MBProgressHUD.showError("请输入合法的手机号")
            return
        }
        
        guard let addressDesc =  addressDescTextView.text ,addressDesc != "" else {
            MBProgressHUD.showError("详细地址不能为空")
            return
        }
        
        guard let category =  selectCategoryBtn?.titleLabel?.text ,category != "" else {
            MBProgressHUD.showError("请选择分类")
            return
        }
        
        let cityCode =  addressCodeToSave
        guard cityCode != 0 else {
            MBProgressHUD.showError("请选择省市区")
            return
        }
        
        let isDefault = useAsDefaultAddressBtn.isSelected == true ? 1 : 0
        
        var addressModify = XFAddress()
        
        addressModify.districtCode  = cityCode
        addressModify.address  = addressDesc
        addressModify.recipient = recipient
        addressModify.cellPhone = cellPhone
        addressModify.isDefault = isDefault
        addressModify.label = category
        
        if let action = actionHandler {
            action(addressModify)  // 传值给添加或修改地址界面
        }
        
    }
    @objc private func checkboxSelect(_ btn:UIButton){
        
        if (!btn.isSelected){
            btn.setImage(UIImage.imageWithNamed("check_box_select"), for: .normal)
            btn.isSelected = true
        }
        else{
            btn.setImage(UIImage.imageWithNamed("checkbox-empty"), for: .normal)
            btn.isSelected = false
        }
    }
    
    private func hideKeyboard(){
        receiveInput.resignFirstResponder()
        mobileInput.resignFirstResponder()
        addressDescTextView.resignFirstResponder()
    }
    
    func widthForLabel(text:NSString ,font :CGFloat) -> CGFloat {
        let size = text.size(withAttributes:[NSAttributedStringKey.font:sysFontWithSize(font)])
        return size.width
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.hideKeyboard()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
}

extension XFEditMyAddressView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == nil || textView.text.isEmpty {
            placeHolderLabel.text = "详细地址（具体到门牌号）"
        } else{
            placeHolderLabel.text = ""
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

extension XFEditMyAddressView: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  defaultCategoryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) ;
        if cell.contentView.subviews.last != nil {
            cell.contentView.subviews.last?.removeFromSuperview()
        }
        let row = indexPath.row
        
        let btn  = UIButton.init(type: .custom)
        btn.setTitle(defaultCategoryData[row], for: .normal)
        btn.frame =  CGRect(x:0, y:0, width: 20 + widthForLabel(text: defaultCategoryData[row] as NSString, font: 14), height:25)
        btn.titleLabel?.font = XFConstants.Font.pfn14
        
        if defaultLabel == defaultCategoryData[row] {
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.backgroundColor = XFConstants.Color.salmon
            self.selectCategoryBtn = btn
        } else{
            btn.setTitleColor(XFConstants.Color.salmon, for: .normal)
            btn.backgroundColor = UIColor.white
        }
        btn.tag = 10000 + row
        cell.contentView.addSubview(btn)
        
        btn.isUserInteractionEnabled  = false
        cell.layer.borderColor = XFConstants.Color.salmon.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize  {
        let row = indexPath.row
        let cate  = defaultCategoryData[row]
        return CGSize(width:20 + widthForLabel(text: cate as NSString, font: 14),height:25)
    }
    
    // 点击某项的事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let row = indexPath.row
        
        self.selectCategoryBtn?.setTitleColor(XFConstants.Color.salmon, for: .normal)
        self.selectCategoryBtn?.backgroundColor = UIColor.white
        
        let btn:UIButton = self.viewWithTag(10000 + row) as! UIButton
        btn.backgroundColor = XFConstants.Color.salmon
        btn.setTitleColor(UIColor.white, for: .normal)
        self.selectCategoryBtn = btn
    }
    
    
}
