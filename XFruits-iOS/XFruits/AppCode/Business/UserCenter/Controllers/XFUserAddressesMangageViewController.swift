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
    
    var addressInfoArray: Array<XFAddress?> = []
    
    var onSelectedAddress: ((XFAddress) -> Void)?
    
    // 地址列表
    lazy var addressesTable: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = XFConstants.Color.separatorLine
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 66
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(XFAddressesManageTableViewCell.self, forCellReuseIdentifier: addressCellIdentifier)
        return tableView
    }()
  
    // 添加地址按钮
    lazy var addAddressBtn:UIButton = {
       let addAddressBtn = UIButton.init()
        addAddressBtn.setTitle("添 加", for: .normal)
        addAddressBtn.setTitleColor(XFConstants.Color.salmon, for: .normal)
        addAddressBtn.titleLabel?.font = XFConstants.Font.pfn16
        addAddressBtn.layer.cornerRadius = 6
        addAddressBtn.layer.borderWidth = 1
        addAddressBtn.layer.borderColor = XFConstants.Color.salmon.cgColor
        addAddressBtn.layer.masksToBounds = true
        addAddressBtn.addTarget(self, action: #selector(addOrModifyAddressEvent(sender:)), for:.touchUpInside)
        return addAddressBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "地址管理"
        
        // 第一次没拉到，继续拉数据
        if XFAvailableAddressUtils.shared.getCachedAddress() == nil {
            XFAvailableAddressUtils.shared.cacheAddressAvailable()
        }
        
        // 空白地址视图
        let emptyAddressView = XFEmptyAddressView()
        self.view.addSubview(emptyAddressView)
        emptyAddressView.snp.makeConstraints({ (make) in
            make.left.right.top.bottom.equalTo(view)
        })
   
        // 地址列表视图
        self.view.addSubview(addressesTable)
        addressesTable.snp.makeConstraints({ (make) in
            make.left.right.top.equalTo(view)
            make.bottom.equalTo(view).offset(-50)
        })
    
        // 底部添加地址按钮
        self.view.addSubview(addAddressBtn)
        addAddressBtn.snp.makeConstraints({ (make) in
            make.height.equalTo(45)
            make.left.equalTo(view).offset(20)
            make.right.bottom.equalTo(view).offset(-20)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getUserAllAddress()
    }
    
    // 获取用户所有地址
    func getUserAllAddress(){
        weak var weakSelf = self
        XFAddressService.getUserAllAddress { (data) in
            if let addresses = data as? Array<XFAddress>{
                
                if (addresses.count > 0) {
                    weakSelf?.addressInfoArray.removeAll()
                    weakSelf?.addressInfoArray = addresses
                    // 小小排序。把默认地址放在第一
                    for(index,value) in (weakSelf?.addressInfoArray.enumerated())!{
                        let addressObject:XFAddress = value!
                        if(addressObject.isDefault == 1){
                            weakSelf?.addressInfoArray.remove(at: index)
                            weakSelf?.addressInfoArray.insert(addressObject, at: 0)
                            break
                        }
                    }
                    
                    weakSelf?.addressesTable.reloadData()
                    weakSelf?.addressesTable.isHidden  = false  // 有地址的时候，tableview 不能隐藏
                }
                else{
                    // 没有地址，把 tableview 隐藏
                    weakSelf?.addressesTable.isHidden = true
                }
             
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

        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.pushViewController(addAddressVC, animated: true)
    }
}

extension XFUserAddressesMangageViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return addressInfoArray.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: addressCellIdentifier, for: indexPath) as! XFAddressesManageTableViewCell
        cell.selectionStyle = .none
        let row = indexPath.row
        if let address : XFAddress = addressInfoArray[row] {
            cell.setMyAddress(data: address)
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
                XFAddressService.deleteAddress(addressId: addressId,params:[:] ){ (data) in
                    if data as! Bool { // 删除成功。
                        weakSelf?.addressInfoArray.remove(at: row)
                        tableView.deleteRows(at: [indexPath], with: .fade)
                        if(weakSelf?.addressInfoArray.count == 0){
                            weakSelf?.addressesTable.isHidden = true
                        }
                        else{
                            weakSelf?.addressesTable.isHidden = false
                        }
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if let onSelected = onSelectedAddress, let address: XFAddress = addressInfoArray[indexPath.row] {
            onSelected(address)
            self.backToParentController()
        }
    }
}
