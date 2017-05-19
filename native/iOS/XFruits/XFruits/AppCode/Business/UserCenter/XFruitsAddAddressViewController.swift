//
//  XFruitsAddAddressViewController.swift
//  XFruits
//
//  Created by zhaojian on 5/18/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class XFruitsAddAddressViewController: XFruitsBaseSubViewController ,UITableViewDataSource,UITableViewDelegate {

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
        
        
        // Do any additional setup after loading the view.
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
        
        print(section)
        print(row)
        let identifier = "addAddressManageCell"
        let cell = XFruitsAddAddressTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
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
