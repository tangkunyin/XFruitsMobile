//
//  XFDetailCommentView.swift
//  XFruits
//
//  Created by tangkunyin on 28/05/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

/// 新增或编辑地址
class XFEditMyAddressView: UIView, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UITextViewDelegate{
    var selectCategoryLabel:UILabel? // 被选中的 label
    var addressCodeToSave:NSNumber = 0 // 选中的 citycode
    
    // 声明闭包
    //    typealias inputClosureType = (String)-> Void
    
    let categoryArray = ["公司","家","学校","前男友家","路人家~","A家","+","-"]  // ,"+","-"
    
    lazy var leftTipReceiveLabel: UILabel = {
        
        // 用户名
        let leftTipReceiveLabel = UILabel.init()
        leftTipReceiveLabel.text = "收货人"
        leftTipReceiveLabel.textColor = colorWithRGB(153, g: 153, b: 153)
        leftTipReceiveLabel.font  = sysFontWithSize(16)
        leftTipReceiveLabel.textAlignment = NSTextAlignment.left
        
        return leftTipReceiveLabel
    }()
    
    
    lazy var receiveInput:UITextField = {
        let receiveInput = UITextField.init()
        receiveInput.text = "赵健"
        receiveInput.textColor  = XFConstants.Color.darkGray
        receiveInput.font = sysFontWithSize(16)
        return receiveInput
        
    }()
    
    lazy var leftMobileLabel: UILabel = {
        
        // 联系电话
        let leftMobileLabel = UILabel.init()
        leftMobileLabel.text = "联系电话"
        leftMobileLabel.textColor = colorWithRGB(153, g: 153, b: 153)
        leftMobileLabel.font  = sysFontWithSize(16)
        leftMobileLabel.textAlignment = NSTextAlignment.left
        
        return leftMobileLabel
    }()
    
    
    lazy var mobileInput :UITextField = {
        // 联系电话输入框
        let mobileInput:UITextField = UITextField.init()
        mobileInput.text = "18658054127"
        mobileInput.textColor  = XFConstants.Color.darkGray
        mobileInput.keyboardType = .numberPad
        mobileInput.font = sysFontWithSize(16)
        return mobileInput
    }()
    
    lazy var leftAddressLabel: UILabel = {
        
        // 收货地址
        let leftAddressLabel = UILabel.init()
        leftAddressLabel.text = "收货地址"
        leftAddressLabel.textColor = colorWithRGB(153, g: 153, b: 153)
        leftAddressLabel.font  = sysFontWithSize(16)
        leftAddressLabel.textAlignment = NSTextAlignment.left
        
        return leftAddressLabel
    }()
    
    
    lazy var addressChooseLabel:UILabel = {
        let addressChooseLabel  = UILabel.init()
//        addressChooseLabel.text = "内蒙古兴安盟扎赉特旗"
        
        addressChooseLabel.textColor  = XFConstants.Color.darkGray
        addressChooseLabel.font = sysFontWithSize(16)
        return addressChooseLabel
    }()
    
    
    
    // 收货地址透明按钮
    lazy var addressBtn : UIButton = {
        let addressBtn = UIButton.init()
        addressBtn.backgroundColor = UIColor.clear
        addressBtn.addTarget(self, action: #selector(chooseAddress(_:)), for: .touchUpInside)
        
        return addressBtn
    }()
    
    
    @objc private func chooseAddress(_ btn:UIButton){
        hideKeyboard()
 
        let cityView = XFCityChooseView.init(frame: self.bounds)
        weak var weakSelf = self
        
        if(weakSelf?.addressChooseLabel.text != nil ){
            cityView.loadDefaultArea(defaultArea: (weakSelf?.addressChooseLabel.text)!)

        }
        cityView.myClosure = { (provinceStr: String, cityStr: String , areaStr: String, addressCodeToSave: NSNumber) -> Void in
            print(addressCodeToSave)
            weakSelf?.addressCodeToSave = addressCodeToSave
            weakSelf?.addressChooseLabel.text = provinceStr + " " + cityStr + " " + areaStr
            
        }
        self.addSubview(cityView)
        
    }
    private func hideKeyboard(){
        receiveInput.resignFirstResponder()
        mobileInput.resignFirstResponder()
        addressDescTextView.resignFirstResponder()
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
    
    lazy var addressDescTextView:UITextView = {
        let descAddress = UITextView()
        descAddress.delegate = self
        
        descAddress.font = sysFontWithSize(16)
        descAddress.isScrollEnabled = false
        return descAddress
        
    }()
    
    lazy var categoryCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //每个Item之间最小的间距
        layout.minimumInteritemSpacing = 5
        //每行之间最小的间距
        layout.minimumLineSpacing = 5
        
        let categoryCollectionView = UICollectionView(frame:CGRect.zero,collectionViewLayout:layout)
        categoryCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        categoryCollectionView.dataSource = self;
        categoryCollectionView.delegate = self;
        categoryCollectionView.backgroundColor = UIColor.white
        return categoryCollectionView
    }()
    
    lazy var useAsDefaultAddressBtn:UIButton = {
        let useAsDefaultAddressBtn = UIButton.init()
        useAsDefaultAddressBtn.backgroundColor = UIColor.clear
        useAsDefaultAddressBtn.setTitle("默认地址", for: .normal)
        useAsDefaultAddressBtn.setImage(UIImage.imageWithNamed("checkbox-empty"), for: .normal)
        useAsDefaultAddressBtn.setTitleColor(colorWithRGB(153, g: 153, b: 153), for: .normal)
        useAsDefaultAddressBtn.addTarget(self, action: #selector(checkboxSelect(_:)), for: .touchUpInside)
        useAsDefaultAddressBtn.isSelected = false
        
        return useAsDefaultAddressBtn
    }()
    
    lazy var placeHolderLabel : UILabel  = {
        let placeHolderLabel = UILabel()
        placeHolderLabel.textColor = XFConstants.Color.darkGray
        placeHolderLabel.text = "详细地址（具体到门牌号）"
        placeHolderLabel.font = sysFontWithSize(14)
        return placeHolderLabel
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
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
            //            make.bottom.equalTo(self.snp.bottom).offset(-12)
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
            make.top.equalTo(line4.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left).offset(5)
            make.right.equalTo(self.snp.right).offset(-5)
//            make.bottom.equalTo(self.snp.bottom).offset(-100)
            make.height.equalTo(55)
        })
        // 默认地址按钮
        
        self.addSubview(useAsDefaultAddressBtn)
        useAsDefaultAddressBtn.snp.makeConstraints( { (make) in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left).offset(5)
            make.right.equalTo(self.snp.right).offset(-5)
            make.height.equalTo(40)
        })
    }
    
    
    func setMyAddress(address:XFAddress)  {
        receiveInput.text = address.recipient
        mobileInput.text = address.cellPhone
        
        addressBtn.setTitle(address.label, for: .normal)
        addressDescTextView.text = address.address
        if  addressDescTextView.text.characters.count > 0 {
            placeHolderLabel.text = ""
        }
        if(address.isDefault == "1"){
            useAsDefaultAddressBtn.setImage(UIImage.imageWithNamed("check_box_select"), for: .normal)
            useAsDefaultAddressBtn.isSelected = true
        }
        let cityView = XFCityChooseView.init(frame: self.bounds)
        
        addressChooseLabel.text = cityView.loadDefaultAreaWithCityCode(cityCode: address.districtCode! )
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == nil || textView.text.isEmpty {
            placeHolderLabel.text = "详细地址（具体到门牌号）"
        }
        else{
            placeHolderLabel.text = ""
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  categoryArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) ;
        if cell.contentView.subviews.last != nil {
            cell.contentView.subviews.last?.removeFromSuperview()
        }
        let row = indexPath.row
        let label = UILabel.init()
        label.text = categoryArray[indexPath.row]
        label.font = sysFontWithSize(10)
        
        label.frame =  CGRect(x:0, y:20, width: 20 + widthForLabel(text: label.text! as NSString, font: 10), height:22)
        label.layer.cornerRadius = 10.0
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.textColor = XFConstants.Color.salmon
        label.layer.borderColor = XFConstants.Color.salmon.cgColor
        label.layer.borderWidth = 0.5
        label.tag = 10000 + row
        cell.contentView.addSubview(label)
        return cell;
    }
    
    func widthForLabel(text:NSString ,font :CGFloat) -> CGFloat {
        let size = text.size(withAttributes:[NSAttributedStringKey.font:sysFontWithSize(font)])
        return size.width
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize  {
        let row = indexPath.row
        let cate  = categoryArray[row]
        return CGSize(width:20 + widthForLabel(text: cate as NSString, font: 10),height:22)
    }
    
    // 点击某项的事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let row = indexPath.row
        print(row)
        if row == categoryArray.count - 1 || row == categoryArray.count - 2 {
//            var alertController = UIAlertController.init(title: "提示", message: "请输入", preferredStyle: .actionSheet)
            
        }
        else{
            let cate  = categoryArray[row]
            print(cate)
            
            self.selectCategoryLabel?.textColor = XFConstants.Color.salmon
            self.selectCategoryLabel?.backgroundColor = UIColor.white
            
            let label:UILabel = self.viewWithTag(10000 + row) as! UILabel
            label.backgroundColor  = XFConstants.Color.salmon
            label.textColor = UIColor.white
            self.selectCategoryLabel = label
        }
       
        
    }
}
