//
//  XFAddressListViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/11/11.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit

fileprivate let addressCellIdentifier = "XFAddressCellIdentifier"

class XFAddressListViewController: XFBaseSubViewController {

    var addressInfoArray: Array<XFAddress?> = []
    
    var onSelectedAddress: ((XFAddress) -> Void)?
    
    // 地址列表
    lazy var addressesListView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = XFConstants.Color.separatorLine
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 92
        tableView.register(XFAddressItem.self, forCellReuseIdentifier: addressCellIdentifier)
        return tableView
    }()
    
    // 添加地址按钮
    lazy var addAddressBtn:UIButton = {
        let addAddressBtn = UIButton.init()
        addAddressBtn.backgroundColor = UIColor.white
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
        
        view.addSubview(addressesListView)
        view.addSubview(addAddressBtn)
        addressesListView.snp.makeConstraints({ (make) in
            make.left.right.top.equalTo(view)
            make.bottom.equalTo(addAddressBtn.snp.top)
        })
        addAddressBtn.snp.makeConstraints({ (make) in
            make.height.equalTo(44)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            } else {
                make.bottom.equalTo(view).offset(-20)
            }
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
                    weakSelf?.removeNullDataView()
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
                    weakSelf?.addressesListView.reloadData()
                } else{
                    weakSelf?.renderNullDataView()
                }
            }
        }
    }
    
    // 添加或编辑地址
    @objc func addOrModifyAddressEvent(sender:UIButton?) {
        let addAddressVC = XFAddressManageViewController()
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

extension XFAddressListViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return addressInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: addressCellIdentifier, for: indexPath) as! XFAddressItem
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
                let addressId = address.id
                XFAddressService.deleteAddress(addressId: addressId,params:[:] ){ (data) in
                    if data as! Bool { // 删除成功。
                        weakSelf?.addressInfoArray.remove(at: row)
                        tableView.deleteRows(at: [indexPath], with: .fade)
                        if weakSelf?.addressInfoArray.count == 0 {
                            weakSelf?.renderNullDataView()
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

