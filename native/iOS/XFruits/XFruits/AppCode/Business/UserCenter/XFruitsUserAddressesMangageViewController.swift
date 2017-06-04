//
//  XFruitsUserAddressesMangageViewController.swift
//  XFruits
//
//  Created by zhaojian on 5/16/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class XFruitsUserAddressesMangageViewController: XFruitsBaseSubViewController,UITableViewDataSource,UITableViewDelegate {
    var addressInfoArray: NSArray?

    override func viewDidLoad() {
        super.viewDidLoad()
        let addressesTable: UITableView! = {
            let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "addressManageCell")
            return tableView
        }()
        self.view.addSubview(addressesTable)
      
        addressesTable.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        })
        addressesTable.estimatedRowHeight = 60
        addressesTable.rowHeight = UITableViewAutomaticDimension
        
        
        // 导航栏右侧添加地址按钮
        let addAddressBtn  = UIButton.init(type:.custom)
        addAddressBtn.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        addAddressBtn.setImage(UIImage.imageWithNamed("myScore"), for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: addAddressBtn)
            
        addAddressBtn.addTarget(self, action: #selector(addAddressEvent(sender:)), for:.touchUpInside)

        
        
        // Do any additional setup after loading the view.
    }
    
    
    func addAddressEvent(sender:UIButton?) {
        dPrint("eyes")
        let addAddressVC = XFruitsAddAddressViewController()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.show(addAddressVC, sender: self)
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
        
        dPrint(section)
        dPrint(row)
        let identifier = "addressManageCell"
        let cell = XFruitsAddressesManageTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
