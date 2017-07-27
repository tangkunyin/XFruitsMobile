//
//  XFChoosePayWayViewController.swift
//  XFruits
//
//  Created by zhaojian on 5/28/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class XFChoosePayWayViewController: XFBaseViewController ,UITableViewDataSource,UITableViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addressesTable: UITableView! = {
            let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(XFPayWayBillContentTableViewCell.self, forCellReuseIdentifier: "XFPayWayBillContentTableViewCell")
            return tableView
        }()
        self.view.addSubview(addressesTable)
        addressesTable.tableFooterView = UIView()
        addressesTable.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
      
        return 3
         
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let section = indexPath.section
        let row = indexPath.row
        
        dPrint(section)
        dPrint(row)
        
        if section == 0  {
            if row == 0 {
                let identifier = "XFPayWayBillInfoTableViewCell"
                let cell = XFPayWayBillInfoTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
                
                return cell
            }
            else   {
                let identifier = "XFPayWayBillContentTableViewCell"
                let cell = XFPayWayBillContentTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
                
                return cell
            }

            
        }
        else  {
            if row == 0 || row == 1 {
                let identifier = "XFTPayModeableViewCell"
                let cell = XFTPayModeableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
                return cell
            }
            else  {
                let identifier = "UITableViewCell"
                let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
                let confirmPayBtn = UIButton()
                confirmPayBtn.setTitle("确认支付", for: .normal)
                cell.contentView.addSubview(confirmPayBtn)
                confirmPayBtn.backgroundColor = colorWithRGB(0, g: 201, b: 1)
                confirmPayBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
                confirmPayBtn.layer.cornerRadius = 15
                confirmPayBtn.layer.masksToBounds   =  true
                confirmPayBtn.snp.makeConstraints({ (make) in
                    make.left.equalTo(cell.snp.left).offset(10)
                    make.right.equalTo(cell.snp.right).offset(-10)
                    
                    make.centerY.equalTo(cell.contentView)
                })
                return cell
            }
        
        
        }
        
        
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
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            if row == 0 {
                return 180
            }
            else {
                return 39.6
            }
        }
        else {
            if row == 0 || row == 1 {
                return 49
            }
            else {
                return 50
            }
        }
        
        
        
        
    }
    

}
