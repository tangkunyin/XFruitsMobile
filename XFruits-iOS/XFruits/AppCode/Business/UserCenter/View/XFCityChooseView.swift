//
//  CityChooseView.swift
//  CityChoose
//
//  Created by lisonglin on 27/04/2017.
//  Copyright © 2017 lisonglin. All rights reserved.
//

import UIKit
import MBProgressHUD
import SnapKit

class XFCityChooseView: UIView,  UIPickerViewDelegate , UIPickerViewDataSource {
    
    var selectRow: Int = 0  // 选中的省
    var provinceStr: String? // 省，字符串
    var cityStr: String?   // 市，字符串
    var areaStr: String?  // 区，字符串
    var addressCodeToSave:Int = 0 // 点击确定最终保存的 citycode
    var addressCodeSelectTemp:Int = 0  // 每转动一次保存的 citycode
    
    var myClosure: ((String, String, String , Int) -> Void)?
    
    fileprivate lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    
    fileprivate lazy var pickerView :UIPickerView = {
        let pv = UIPickerView()
        pv.backgroundColor = UIColor.white
        pv.delegate = self
        pv.dataSource = self
        return pv
    }()
    
    fileprivate lazy var toolBarView: UIView = {
        let tv = UIView()
        tv.backgroundColor = UIColor.groupTableViewBackground
        return tv
    }()
    
    fileprivate lazy var cancleBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("取消", for: UIControlState.normal)
        btn.titleLabel?.font = XFConstants.Font.pfn14
        btn.layer.cornerRadius = 5
        btn.setTitleColor(XFConstants.Color.darkGray, for: .normal)
        btn.addTarget(self, action: #selector(cancleBtnClick), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    fileprivate lazy var sureBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("确定", for: UIControlState.normal)
        btn.titleLabel?.font = XFConstants.Font.pfn14
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initSubViews()
        self.loadDatas()
    }
    
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
    
    func loadDefaultAreaWithCityCode(cityCode:Int) -> String {  // 按照 citycode 找省市区
        addressCodeSelectTemp = cityCode
        if let addressInfo:NSDictionary = XFAvailableAddressUtils.shared.getCachedAddress() {
            let districtArr = addressInfo.object(forKey: "district") as! NSArray
            for dic  in districtArr {  // 第一个 district 数组
                
                let dict:NSDictionary = dic as! NSDictionary
                
                let firstDistrictArr = dict["subDistrict"] as! NSArray
                for fistDisctTemp in firstDistrictArr {
                    
                    let fistDisct:NSDictionary = fistDisctTemp as! NSDictionary
                    let subDistrictArr = fistDisct["subDistrict"] as! NSArray
                    
                    for subDisctTemp in subDistrictArr {
                        let subDisct:NSDictionary = subDisctTemp as! NSDictionary
                        
                        if (subDisct["code"] as! Int == cityCode){
                            var provinceName:String  = dict["name"] as! String
                            provinceName =  "\(provinceName) \(fistDisct["name"] as! String)"
                            provinceName =  "\(provinceName) \(subDisct["name"] as! String)"
                            return provinceName
                        }
                    }
                }
            }
        }
        return ""
    }
    
    // 加载取消、确定按钮等。
    func initSubViews() -> Void {
        self.alpha = 0
        self.addSubview(self.bgView)
        self.bgView.addSubview(self.pickerView)
        self.bgView.addSubview(self.toolBarView)
        self.toolBarView.addSubview(self.cancleBtn)
        self.toolBarView.addSubview(self.sureBtn)

        bgView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self)
        }
        pickerView.snp.makeConstraints { (make) in
            make.height.equalTo(216)
            make.left.right.bottom.equalTo(bgView)
        }
        toolBarView.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.left.right.equalTo(bgView)
            make.bottom.equalTo(pickerView.snp.top)
        }
        cancleBtn.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(toolBarView)
            make.width.equalTo(sureBtn.snp.width)
            make.left.equalTo(toolBarView).offset(15)
        }
        sureBtn.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(toolBarView)
            make.width.equalTo(cancleBtn.snp.width)
            make.right.equalTo(toolBarView).offset(-15)
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
        if let addressInfo: NSDictionary = XFAvailableAddressUtils.shared.getCachedAddress() {
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
            addressCodeSelectTemp  = dict["code"] as! Int
        } else {
            MBProgressHUD.showError("地区数据加载错误")
        }
    }
    
    //根据市获取区
    func getAreaNameFromCity(row: NSInteger) -> NSArray {
        if let addressInfo: NSDictionary = XFAvailableAddressUtils.shared.getCachedAddress() {
            let districtArr = addressInfo.object(forKey: "district") as! NSArray
            let districtDict = districtArr[self.selectRow] as! NSDictionary
            let firtDictrictArr = districtDict["subDistrict"] as! NSArray
            let subDistrictDict =  firtDictrictArr[row] as! NSDictionary
            let subDistrictArr = subDistrictDict["subDistrict"] as! NSArray
            return subDistrictArr
        }
        return []
    }
    
    //根据省名称获取市
    func getCityNameFromProvince(row: NSInteger) -> NSArray {
        if let addressInfo: NSDictionary = XFAvailableAddressUtils.shared.getCachedAddress() {
            let cityArray = NSMutableArray()
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
        return []
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
            addressCodeSelectTemp = dict["code"] as! Int
        case 1: //选择市
            self.areaArray = self.getAreaNameFromCity(row: row)
            self.pickerView.reloadComponent(2)
            self.pickerView.selectRow(0, inComponent: 2, animated: true)
            
            self.cityStr = self.cityArray[row] as? String
            
            let dict = self.areaArray[0] as! NSDictionary
         
            self.areaStr = dict["name"] as? String
            addressCodeSelectTemp = dict["code"] as! Int
        
        default: //选择区
            let dict = self.areaArray[row] as! NSDictionary
            self.areaStr = dict["name"] as? String
            addressCodeSelectTemp = dict["code"] as! Int
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
    }
    
    //确定按钮
    @objc func sureBtnClick()  {
        self.hidePickerView()
        addressCodeToSave = addressCodeSelectTemp
        if let myClosure = myClosure {
            myClosure(self.provinceStr!, self.cityStr!, self.areaStr!, self.addressCodeToSave)
        }
    }
    
    //showPickerView
    func showPickerView() -> Void {
        weak var weakSelf = self
        UIView.animate(withDuration: 0.4) {
            weakSelf?.alpha = 1
        }
    }
    
    //hidePickerView
    func hidePickerView() -> Void {
        weak var weakSelf = self
        UIView.animate(withDuration: 0.4) {
            weakSelf?.alpha = 0
        }
    }

}

