//
//  CityChooseView.swift
//  CityChoose
//
//  Created by lisonglin on 27/04/2017.
//  Copyright © 2017 lisonglin. All rights reserved.
//

import UIKit

let XF_PICKERHEIGHT: CGFloat = 216
let XF_BGHEIGHT: CGFloat = 256
let XF_BGWIDTH = UIScreen.main.bounds.width

let XF_KEY_WINDOW_HEIGHT = UIApplication.shared.keyWindow?.frame.size.height

// picker 选择结果返回给编辑界面
typealias XF_ResultClosure = (String, String, String , NSNumber) -> Void

class XFCityChooseView: UIView,  UIPickerViewDelegate , UIPickerViewDataSource {
    
    var selectRow: Int = 0  // 选中的省
    
    var provinceStr: String? // 省，字符串
    var cityStr: String?   // 市，字符串
    var areaStr: String?  // 区，字符串
    var addressCodeToSave:NSNumber = 0 // 点击确定最终保存的 citycode
    var addressCodeSelectTemp:NSNumber = 0  // 每转动一次保存的 citycode
    
    var myClosure: XF_ResultClosure?
    
    
    fileprivate lazy var bgView: UIView = {
        let view = UIView()
        view.frame = CGRect.init(x: 0, y: UIScreen.main.bounds.height, width: XF_BGWIDTH, height: XF_BGHEIGHT)
        view.backgroundColor = UIColor.white
        return view
    }()
    
    fileprivate lazy var pickerView :UIPickerView = {
        let pv = UIPickerView()
        pv.frame = CGRect.init(x: 0, y: XF_BGHEIGHT - XF_PICKERHEIGHT, width: XF_BGWIDTH, height: XF_PICKERHEIGHT)
        pv.delegate = self
        pv.dataSource = self
        return pv
    }()
    
    fileprivate lazy var toolBarView: UIView = {
        let tv = UIView()
        tv.frame = CGRect.init(x: 0, y: 0, width: XF_BGWIDTH, height: XF_BGHEIGHT - XF_PICKERHEIGHT)
        tv.backgroundColor = UIColor.groupTableViewBackground
        return tv
    }()
    
    fileprivate lazy var cancleBtn: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect.init(x: 10, y: 5, width: 50, height: XF_BGHEIGHT - XF_PICKERHEIGHT - 10)
        btn.setTitle("取消", for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.layer.cornerRadius = 5
        btn.setTitleColor(XFConstants.Color.darkGray, for: .normal)
        btn.addTarget(self, action: #selector(cancleBtnClick), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    fileprivate lazy var sureBtn: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect.init(x: XF_BGWIDTH - 60, y: 5, width: 50, height: XF_BGHEIGHT - XF_PICKERHEIGHT - 10)
        btn.setTitle("确定", for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.layer.cornerRadius = 5
        btn.setTitleColor(XFConstants.Color.darkGray, for: .normal)
        btn.addTarget(self, action: #selector(sureBtnClick), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    fileprivate lazy var provinceArray: NSArray = {
        let array: NSArray = NSArray()
        return array
    }()
    
    fileprivate lazy var cityArray: NSArray = {
        let array: NSArray = NSArray()
        return array
    }()
    
    fileprivate lazy var areaArray: NSArray = {
        let array: NSArray = NSArray()
        return array
    }()
    
    fileprivate lazy var dataSource: NSArray = {
        let array: NSArray = NSArray()
        return array
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubViews()
        self.loadDatas()

    }
    
    // 选中后重新选择时候，安装字符串，自动滚动 picker
    func loadDefaultArea(defaultArea:String) {
        let areaArr = defaultArea.components(separatedBy: " ")
        if(areaArr.count == 3 ){
            self.selectRowAndPromnent(province: areaArr[0], city:areaArr[1] , area:areaArr[2] )
            provinceStr  =  areaArr[0]
            cityStr = areaArr[1]
            areaStr  = areaArr[2]
        }
    }
    
    func loadDefaultAreaWithCityCode(cityCode:NSNumber) -> String{  // 按照 citycode 找省市区
        addressCodeSelectTemp = cityCode
        
        let addressInfo:NSDictionary = XFAvailableAddressUtils.shared.getCachedAddress()!
        let districtArr = addressInfo.object(forKey: "district") as! NSArray
        
        for dic  in districtArr {  // 第一个 district 数组
    
            let dict:NSDictionary = dic as! NSDictionary
            
            let firstDistrictArr = dict["subDistrict"] as! NSArray
            for fistDisctTemp in firstDistrictArr {
                
                let fistDisct:NSDictionary = fistDisctTemp as! NSDictionary
                let subDistrictArr = fistDisct["subDistrict"] as! NSArray
                
                for subDisctTemp in subDistrictArr {
                    let subDisct:NSDictionary = subDisctTemp as! NSDictionary

                    if (subDisct["code"] as! NSNumber == cityCode){
                        var provinceName:String  = dict["name"] as! String
                        provinceName =  "\(provinceName) \(fistDisct["name"] as! String)"
                        provinceName =  "\(provinceName) \(subDisct["name"] as! String)"
                       return provinceName
                    }
                }
            }
        }
        return ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 加载取消、确定按钮等。
    func initSubViews() -> Void {
        self.addSubview(self.bgView)
        
        self.bgView.addSubview(self.pickerView)
        
        self.bgView.addSubview(self.toolBarView)
        self.toolBarView.addSubview(self.cancleBtn)
        self.toolBarView.addSubview(self.sureBtn)
        self.showPickerView()
    }
    
    //showPickerView
    func showPickerView() -> Void {
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            self.bgView.frame = CGRect.init(x: 0, y: XF_KEY_WINDOW_HEIGHT! - XF_BGHEIGHT, width: XF_BGWIDTH, height: XF_BGHEIGHT)
        }
    }
    
    //hidePickerView
    func hidePickerView() -> Void {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.bgView.frame = CGRect.init(x: 0, y: XF_KEY_WINDOW_HEIGHT!, width: XF_BGWIDTH, height: XF_BGHEIGHT)
            self.alpha = 0
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
    // 传入省市区，自动选中对应的 picker 位置
    func selectRowAndPromnent(province:String,city:String,area:String)  {
     self.selectRow = self.provinceArray.index(of: province)
       
        self.pickerView.reloadComponent(0)
        self.pickerView.selectRow(self.selectRow, inComponent: 0, animated: true)
        
       
        self.cityArray = self.getCityNameFromProvince(row: self.selectRow)
        let cityIndex  = self.cityArray.index(of: city)
        self.areaArray = self.getAreaNameFromCity(row: cityIndex)
        self.pickerView.reloadComponent(1)
        
        self.pickerView.selectRow(cityIndex, inComponent: 1, animated: true)
        
        for index in 0..<self.areaArray.count {
            let dict  = self.areaArray[index] as! NSDictionary
            if (area == dict["name"] as! String) {
                self.pickerView.reloadComponent(2)
                self.pickerView.selectRow(index, inComponent: 2, animated: true)
                break
            }
        }
    }
    
    // 第一次加载省市区的 array
    func loadDatas() -> Void {
        let addressInfo:NSDictionary = XFAvailableAddressUtils.shared.getCachedAddress()!
        let tempProvince = NSMutableArray()
        
        let districtArr = addressInfo.object(forKey: "district") as! NSArray
        for dic  in districtArr {
            let dict:NSDictionary = dic as! NSDictionary
            let a:String  = dict["name"] as! String
            tempProvince.add(a)
        }
        self.provinceArray = tempProvince.copy() as! NSArray
        self.cityArray = self.getCityNameFromProvince(row: 0)
        self.areaArray = self.getAreaNameFromCity(row: 0)

        self.provinceStr = self.provinceArray[0] as? String
        self.cityStr = self.cityArray[0] as? String
        let dict = self.areaArray[0] as! NSDictionary

        self.areaStr = dict["name"] as? String
        addressCodeSelectTemp  = dict["code"] as! NSNumber
    }
    
    //根据市获取区
    func getAreaNameFromCity(row: NSInteger) -> NSArray {
        let addressInfo:NSDictionary = XFAvailableAddressUtils.shared.getCachedAddress()!
        let districtArr = addressInfo.object(forKey: "district") as! NSArray
        let districtDict = districtArr[self.selectRow] as! NSDictionary
        let firtDictrictArr = districtDict["subDistrict"] as! NSArray
        let subDistrictDict =  firtDictrictArr[row] as! NSDictionary
        let subDistrictArr = subDistrictDict["subDistrict"] as! NSArray
        return subDistrictArr
    }
    
    //根据省名称获取市
    func getCityNameFromProvince(row: NSInteger) -> NSArray {
        
        let cityArray = NSMutableArray()

        let addressInfo:NSDictionary = XFAvailableAddressUtils.shared.getCachedAddress()!
        
        let districtArr = addressInfo.object(forKey: "district") as! NSArray
        
        let dict:NSDictionary = districtArr[row] as! NSDictionary
        let firstDistrict = dict["subDistrict"] as! NSArray
        
        for dic  in firstDistrict{
            let firstDic:NSDictionary = dic as! NSDictionary
            let a  = firstDic["name"] as! String
            cityArray.add(a)
        }
        return cityArray
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return self.provinceArray.count
        case 1:
            return self.cityArray.count
        case 2:
            return self.areaArray.count
        default:
            return 0
        }
    }
    
    //delegate
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width / 3, height: 30))
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = NSTextAlignment.center
        switch component {
        case 0:
            label.text = self.provinceArray[row] as? String
        case 1:
            label.text = self.cityArray[row] as? String
        case 2:
            let dict = self.areaArray[row] as! NSDictionary
            
            label.text = dict["name"] as? String
        default:
            label.text = nil
        }
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0: //选择省
            self.selectRow = row
            self.cityArray = self.getCityNameFromProvince(row: row)
            self.areaArray = self.getAreaNameFromCity(row: 0)
            
            self.pickerView.reloadComponent(1)
            self.pickerView.selectRow(0, inComponent: 1, animated: true)
            self.pickerView.reloadComponent(2)
            self.pickerView.selectRow(0, inComponent: 2, animated: true)
            
            self.provinceStr = self.provinceArray[row] as? String
            self.cityStr = self.cityArray[0] as? String
            let dict = self.areaArray[0] as! NSDictionary
        
            self.areaStr = dict["name"] as? String
            
            addressCodeSelectTemp = dict["code"] as! NSNumber
            
        case 1: //选择市
            self.areaArray = self.getAreaNameFromCity(row: row)
            self.pickerView.reloadComponent(2)
            self.pickerView.selectRow(0, inComponent: 2, animated: true)
            
            self.cityStr = self.cityArray[row] as? String
            
            let dict = self.areaArray[0] as! NSDictionary
         
            self.areaStr = dict["name"] as? String
            addressCodeSelectTemp = dict["code"] as! NSNumber
        
        default: //选择区
            let dict = self.areaArray[row] as! NSDictionary
            self.areaStr = dict["name"] as? String
            addressCodeSelectTemp = dict["code"] as! NSNumber
            break
            
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    
    //取消按钮
    @objc func cancleBtnClick()  {
        self.hidePickerView()
        if self.myClosure != nil {
            self.myClosure!("", "", "", 0)
        }
    }
    
    //确定按钮
    @objc func sureBtnClick()  {
        self.hidePickerView()
        addressCodeToSave = addressCodeSelectTemp
        
        print(addressCodeToSave)
        if self.myClosure != nil {
            self.myClosure!(self.provinceStr!, self.cityStr!, self.areaStr!, self.addressCodeToSave)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.hidePickerView()
    }
    
}

