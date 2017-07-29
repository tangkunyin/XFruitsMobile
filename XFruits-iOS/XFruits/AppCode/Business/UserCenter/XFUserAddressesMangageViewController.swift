//
//  XFUserAddressesMangageViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

fileprivate let addressCellIdentifier = "XFAddressCellIdentifier"

class XFUserAddressesMangageViewController: XFBaseSubViewController {
    
    var addressInfoArray:Array<XFAddress?> = []
    
    lazy var addressesTable: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = XFConstants.Color.separatorLine
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.tableFooterView = UIView()
        tableView.register(XFAddressesManageTableViewCell.self, forCellReuseIdentifier: addressCellIdentifier)
        return tableView
    }()
    
    lazy var request:XFCommonService = {
        let serviceRequest = XFCommonService()
        return serviceRequest
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "地址管理"
        self.view.addSubview(addressesTable)
        addressesTable.snp.makeConstraints({ (make) in
            make.center.size.equalTo(view)
        })
        
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
    
    // 获取用户所有地址
    func getUserAllAddress(){
        weak var weakSelf = self
        request.getUserAllAddress { (data) in
            if let addresses = data as? Array<XFAddress>{
                if (weakSelf?.addressInfoArray.count)! > 0 {
                    weakSelf?.addressInfoArray.removeAll()
                }
                weakSelf?.addressInfoArray = addresses
                weakSelf?.addressesTable.reloadData()
            }
        }
    }
    
    // 添加或编辑地址
    @objc func addOrModifyAddressEvent(sender:UIButton?) {
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
}

extension XFUserAddressesMangageViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return addressInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: addressCellIdentifier, for: indexPath) as! XFAddressesManageTableViewCell
        if let address : XFAddress = addressInfoArray[indexPath.row] {
            cell.setMyAddress(address: address)
            cell.editAddressBtn.addTarget(self, action: #selector(addOrModifyAddressEvent(sender:)), for:.touchUpInside)
            cell.editAddressBtn.tag = 100 + indexPath.row
        }
        
        return cell
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
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
