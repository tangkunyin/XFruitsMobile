//
//  XFUserAddressesMangageViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class XFUserAddressesMangageViewController: XFBaseSubViewController,UITableViewDataSource,UITableViewDelegate {
    
    var addressInfoArray:Array<XFAddress?> = []
    
    
    lazy var addressesTable: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "addressManageCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "地址管理"
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
        
        addAddressBtn.addTarget(self, action: #selector(addOrModifyAddressEvent(sender:)), for:.touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getUserAllAddress()
        
    }
    
    lazy var request:XFCommonService = {
        let serviceRequest = XFCommonService()
        return serviceRequest
    }()
    
    
    // 获取用户所有地址
    func getUserAllAddress(){

        weak var weakSelf = self

        request.getUserAllAddress(token: XFUserGlobal.shared.token!, { (data) in
            if let addresses = data as? Array<XFAddress>{
                if (weakSelf?.addressInfoArray.count)! > 0 {
                    weakSelf?.addressInfoArray.removeAll()
                }
                weakSelf?.addressInfoArray = addresses
                weakSelf?.addressesTable.reloadData()
            }
        })
    }
    
    // 添加或编辑地址
    @objc func addOrModifyAddressEvent(sender:UIButton?) {
        dPrint("eyes")
        let addAddressVC = XFAddAddressViewController()
        let btn:UIButton = sender!
        let tag:Int = btn.tag
        
        if tag >= 100 {  // 编辑模式
            addAddressVC.editStyle = 1
            if let address : XFAddress = addressInfoArray[tag-100] {
                addAddressVC.addressSigleEdit = address
            }
        }
        else{  // 非编辑模式
            addAddressVC.editStyle = 0
        }

        self.navigationController?.navigationBar.tintColor = UIColor.white
       
        self.navigationController?.show(addAddressVC, sender: self)
 
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:列表代理
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return addressInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let section = indexPath.section
        let row = indexPath.row
        dPrint(section)
        dPrint(row)
        
        let identifier = "addressManageCell"
        let cell = XFAddressesManageTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        
        if let address : XFAddress = addressInfoArray[row] {
            cell.setMyAddress(address: address)
            cell.editAddressBtn?.addTarget(self, action: #selector(addOrModifyAddressEvent(sender:)), for:.touchUpInside)
            cell.editAddressBtn?.tag = 100 + row
        }
                 
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 6
    }
    
    //MARK: 删除
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool  {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle{
        return .delete
    }

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?{
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        
        let row = indexPath.row
        weak var weakSelf = self
        
        if editingStyle == .delete{
            
            if let address : XFAddress = addressInfoArray[row] {
                let addressId = address.id!
                request.deleteAddress(addressId: addressId,params:[:] ){ (data) in
        
                    if data as! Bool { // 删除成功。
                        
                        weakSelf?.addressInfoArray.remove(at: row)
                        
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                    
                }
                
            }
        }
        else{
            
        }
    }
    
}

