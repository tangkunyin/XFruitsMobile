//
//  XFruitsAddAddressViewController.swift
//  XFruits
//
//  Created by zhaojian on 5/18/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class XFruitsAddAddressViewController: XFruitsBaseSubViewController ,UITableViewDataSource,UITableViewDelegate  {
   
    var editStyle: NSString?  // 0 为增加模式，1为编辑模式。
    var leftTipArray:NSArray? // 左侧提示
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "新增地址"
        
        
        // 测试用。
        let eidtAddressView = XFEditMyAddressView()
        self.view.addSubview(eidtAddressView)
        
        eidtAddressView.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        })
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
//        let addressesTable: UITableView! = {
//            let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
//            tableView.delegate = self
//            tableView.dataSource = self
//            tableView.register(XFruitsAddAddressTableViewCell.self, forCellReuseIdentifier: "XFruitsAddAddressTableViewCell")
//            return tableView
//        }()
//      
//       self.view.addSubview(addressesTable)
//        addressesTable.snp.makeConstraints({ (make) in
//            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
//        })
//        
//        self.leftTipArray  = ["收货人","联系电话","收货地址"]
//        
//        // 导航栏右侧保存按钮
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "保存", style: .plain, target: self, action: #selector(saveAddress(sender:)))
        
        
    }
    
    // 导航栏右侧按钮-保存-触发的事件
    func saveAddress(sender:UIButton?) {
        print("save")
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 5
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let section = indexPath.section
        let row = indexPath.row
        
        
        let identifier = "XFruitsAddAddressTableViewCell"
        let cell = XFruitsAddAddressTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        
        if row <= 2{
            let leftTip  = self.leftTipArray?[row]
            cell.leftTipLabel?.text = leftTip as? String
        }
       
        
        if row == 2 {
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell.inputContentTextFiled?.isEnabled = false
            cell.inputContentTextFiled?.tag = 1000
        }
      
        else if row == 3 {
            let identifier = "addAddressTextViewManageCell"
            let cell = XFruitsAddressTextViewWithPlaceHolderTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            return cell
        }
        else if row == 4 {
            let identifier = "XFruitsAddressesCategoryTableViewCell"
            let cell = XFruitsAddressesCategoryTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            return cell
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        let section = indexPath.section
        let row = indexPath.row
        if row == 2 {
            print("开始选择三级联动")
            let cityView = CityChooseView.init(frame: self.view.bounds)
            
            cityView.myClosure = { (provinceStr: String, cityStr: String , areaStr: String) -> Void in
                
                print(provinceStr+cityStr+areaStr)
                
                let inputAddress = self.view.viewWithTag(1000) as! UITextField
                inputAddress.text = provinceStr + " " + cityStr + " " + areaStr
         
            }
            self.view.addSubview(cityView)
        }
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 6
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat  {
        let row = indexPath.row
        if row == 3 {
            return 100
        }
        else if row == 4 {
            return 250
        }
        else {
            return tableView.rowHeight
        }
    }

    //设置选择框的列数为3列,继承于UIPickerViewDataSource协议
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
}
