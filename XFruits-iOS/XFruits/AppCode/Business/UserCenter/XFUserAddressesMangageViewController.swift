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
    
    lazy var emptyBgView:UIView = {
        let  emptyBgView = UIView()
        emptyBgView.backgroundColor = UIColor.white
        return emptyBgView
    }()
    
    lazy var emptyAddressTipLabel:UILabel = {
       let emptyAddressTipLabel = UILabel()
        emptyAddressTipLabel.text = "快去添加地址吧~"
        emptyAddressTipLabel.textAlignment = .center
        emptyAddressTipLabel.textColor = XFConstants.Color.greyishBrown
        return emptyAddressTipLabel
    }()
    
    lazy var emptyAddressImageView:UIImageView = {
        let  emptyAddressImageView = UIImageView.init(image: UIImage.imageWithNamed("emptyAddress"))
        return emptyAddressImageView
    }()
    
    
    lazy var addAddressBtn:UIButton = {
       let addAddressBtn = UIButton.init()
        addAddressBtn.setTitle("+ 添加地址", for: .normal)
        addAddressBtn.backgroundColor = XFConstants.Color.salmon
        addAddressBtn.setTitleColor(UIColor.white, for: .normal)
        addAddressBtn.addTarget(self, action: #selector(addOrModifyAddressEvent(sender:)), for:.touchUpInside)
        return addAddressBtn
    }()
    
    lazy var request:XFCommonService = {
        let serviceRequest = XFCommonService()
        return serviceRequest
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "地址管理"
        
        self.view.addSubview(emptyBgView)
        
        emptyBgView.addSubview(emptyAddressTipLabel)
   
      
        emptyBgView.snp.makeConstraints({ (make) in
            make.center.size.equalTo(view)
        })
        
       
        emptyAddressTipLabel.snp.makeConstraints({ (make) in
            make.left.equalTo(emptyBgView.snp.left)
            make.right.equalTo(emptyBgView.snp.right)
            make.center.equalTo(self.view)
            make.height.equalTo(30)
 
        })
 
        emptyBgView.addSubview(emptyAddressImageView)
        emptyAddressImageView.snp.makeConstraints({ (make) in
            make.bottom.equalTo(emptyAddressTipLabel.snp.top).offset(-5)
 
            make.centerX.equalTo(self.view)
            make.width.height.equalTo(100)
        })
   
        self.view.addSubview(addressesTable)
        addressesTable.snp.makeConstraints({ (make) in
            make.center.size.equalTo(view)
        })
    
        self.view.addSubview(addAddressBtn)
        
        addAddressBtn.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self.view.snp.bottom).offset(-10)
            make.centerX.equalTo(self.view)
            make.width.equalTo(150)
            make.height.equalTo(35)
        })
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
                
                if (addresses.count > 0) {
                    weakSelf?.addressInfoArray.removeAll()
                    weakSelf?.addressInfoArray = addresses
                    weakSelf?.addressesTable.reloadData()
                  
                     weakSelf?.addressesTable.isHidden  = false
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
        if let onSelected = onSelectedAddress, let address: XFAddress = addressInfoArray[indexPath.row] {
            onSelected(address)
            self.backToParentController()
        }
    }
}
