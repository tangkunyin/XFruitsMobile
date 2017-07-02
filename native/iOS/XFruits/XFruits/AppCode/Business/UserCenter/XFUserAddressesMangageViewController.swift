//
//  XFUserAddressesMangageViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class XFUserAddressesMangageViewController: XFBaseSubViewController,UITableViewDataSource,UITableViewDelegate {
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
        addAddressBtn.setImage(UIImage.imageWithNamed("add"), for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: addAddressBtn)
        
        addAddressBtn.addTarget(self, action: #selector(addAddressEvent(sender:)), for:.touchUpInside)
        
    }
    
    
    func addAddressEvent(sender:UIButton?) {
        dPrint("eyes")
        let addAddressVC = XFAddAddressViewController()
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
        let cell = XFAddressesManageTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        
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
    
    
}
