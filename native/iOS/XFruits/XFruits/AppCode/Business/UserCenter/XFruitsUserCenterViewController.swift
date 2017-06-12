//
//  XFruitsUserCenterViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/4/23.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit

class XFruitsUserCenterViewController: XFruitsBaseViewController ,UITableViewDataSource,UITableViewDelegate {
    var secondGroupTitleArray: NSArray?
    var secondGroupIconArray: NSArray?
    
    var thirdGroupTitleArray: NSArray?
    var thirdGourpIconArray: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let centerTable: UITableView! = {
            let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            return tableView
        }()
        self.view.addSubview(centerTable)
        
        centerTable.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        })
        
        secondGroupTitleArray  =  ["我的积分","我的优惠券","我的红包","地址管理"]
        secondGroupIconArray = ["myScore","myDiscountCoupon","myRedPacket","myLocation"]
        
        
        thirdGroupTitleArray = ["联系客服","吐槽&建议","关于我们"]
        thirdGourpIconArray = ["myService","myAdvice","aboutme"]
        
        // 进入登录页面
        let login = XFruitsUserLoginViewController()
        let nav = UINavigationController.init(rootViewController: login)
        present(nav, animated: true, completion: nil)
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4;
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return 2
        }
        else if section == 2{
            return 4
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        let section = indexPath.section
        let row = indexPath.row
        if section == 0{
            return 105
        }
        else if (section == 1 && row == 1) {
            return 90
        }
        return 42
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let section = indexPath.section
        let row = indexPath.row
        
        
        
        if section == 0 {
            let identifier = "mainCell"
            let cell = UserCenterAvatarCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            
            return cell
        }
            
        else if section == 1 {
            if row == 0 {
                let identifier = "commonCell"
                let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
                cell.textLabel?.text = "我的订单"
                cell.textLabel?.textColor = colorWithRGB(83, g: 83, b: 83)
                cell.imageView?.image = UIImage.imageWithNamed("mybill")
                
                cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                
                return cell
            }
                
                
            else {
                let identifier = "billCell"
                let cell = MyBillTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
                
                return cell
                
            }
        }
        else if section == 2 {
            let identifier = "commonCell"
            let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            cell.textLabel?.text = secondGroupTitleArray![row] as? String
            
            cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
            cell.textLabel?.textColor = colorWithRGB(83, g: 83, b: 83)
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell.imageView?.image = UIImage.imageWithNamed((secondGroupIconArray![row] as? String)!)
            return cell
        }
            
        else {
            let identifier = "commonCell"
            let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            cell.textLabel?.text = thirdGroupTitleArray![row] as? String
            cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
            cell.textLabel?.textColor = colorWithRGB(83, g: 83, b: 83)
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell.imageView?.image = UIImage.imageWithNamed((thirdGourpIconArray![row] as? String)!)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 2 && row == 3  {
            let addressManageVC = XFruitsUserAddressesMangageViewController()
            self.navigationController?.navigationBar.tintColor = UIColor.white
            self.navigationController?.show(addressManageVC, sender: self)
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 6
    }
    
    
    
}
