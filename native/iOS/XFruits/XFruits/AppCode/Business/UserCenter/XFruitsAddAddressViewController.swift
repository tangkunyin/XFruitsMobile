//
//  XFruitsAddAddressViewController.swift
//  XFruits
//
//  Created by zhaojian on 5/18/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class XFruitsAddAddressViewController: XFruitsBaseSubViewController ,UITableViewDataSource,UITableViewDelegate {
   
    var editStyle: NSString?  // 0 为增加模式，1为编辑模式。
    var leftTipArray:NSArray? // 左侧提示
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "新增地址"
        let addressesTable: UITableView! = {
            let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "addAddressManageCell")
            return tableView
        }()
      
        self.view.addSubview(addressesTable)
        addressesTable.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        })
        
        self.leftTipArray  = ["收货人","联系电话","收货地址"]
        
        // 导航栏右侧保存按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: self, action: #selector(saveAddress(sender:)))
        
        // Do any additional setup after loading the view.
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
        
        return 4
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let section = indexPath.section
        let row = indexPath.row
        
        print(section)
        print(row)
        let identifier = "addAddressManageCell"
        let cell = XFruitsAddAddressTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        
        if row < 3{
            let leftTip  = self.leftTipArray?[row]
            cell.leftTipLabel?.text = leftTip as? String
        }
       
        
        
        if row == 2 {
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            
        }
      
        else if row == 3 {
            let identifier = "addAddressTextViewManageCell"
            let cell = XFruitsAddressTextViewWithPlaceHolderTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            return cell
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        //        let section = indexPath.section
        //        let row = indexPath.row
        
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
        else {
            return tableView.rowHeight
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
