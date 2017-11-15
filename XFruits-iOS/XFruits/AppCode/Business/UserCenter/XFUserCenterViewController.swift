//
//  XFUserCenterViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import SwiftyJSON

fileprivate let UC_CellIdentifier = "XFUserCenterUC_CellIdentifier"

class XFUserCenterViewController: XFBaseViewController {
    
    lazy var girdGroupInfo: Array<Array<Dictionary<String, String>>> = {
        return [
            [
                ["title":"地址管理", "icon":"myLocation"],
//                ["title":"你的收藏", "icon":"myCollection"],
//                ["title":"你的积分", "icon":"myScore"],
                ["title":"卡券中心", "icon":"myVipCards"]
            ],
            [
                ["title":"吐槽建议", "icon":"myAdvice"],
                ["title":"品牌故事", "icon":"myCompanyBrand"]
            ],
            [
                ["title":"设置", "icon":"app-settings"],
                 ["title":"关于我们", "icon":"aboutme"]
            ]
        ]
    }()
    
    lazy var centerTable: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionFooterHeight = 8
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.separatorColor = XFConstants.Color.separatorLine
        tableView.backgroundColor = XFConstants.Color.separatorLine
        tableView.register(XFUCenterCommonCell.self, forCellReuseIdentifier: UC_CellIdentifier)
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        centerTable.reloadSections(IndexSet(integer: 0), with: .none)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(centerTable)
        centerTable.snp.makeConstraints({ (make) in
            make.center.size.equalTo(view)
        })
    }
    
    fileprivate func jumpToOrder(_ status: String? = nil, title: String){
        if XFUserGlobal.shared.isLogin {
            let orderList = XFOrderListViewController()
            orderList.orderStatus = status
            orderList.title = "\(title)订单"
            navigationController?.pushViewController(orderList, animated: true)
        } else {
            weak var weakSelf = self
            showMessage("请您登陆后再查看\(title)订单", completion: {
                weakSelf?.handleEntrySelect(indexPath: IndexPath(row: 2, section: 1))
            })
        }
    }
    
    fileprivate func handleEntrySelect(indexPath: IndexPath) {
        var subViewController: UIViewController?
        let section = indexPath.section
        let row = indexPath.row
        if section < 3 {
            if XFUserGlobal.shared.isLogin {
                if section == 0 && row == 0 {
                    // 用户信息
                    subViewController = XFUserInfoViewController()
                } else if section == 1 && row == 0 {
                    // 订单列表
                    jumpToOrder(title: "全部")
                } else if section == 1 && row == 1 {
                    // 特定类型订单
                    return
                } else {
                    switch row {
                    case 0:
                        subViewController = XFAddressListViewController()
                    case 1:
                        subViewController = XFCouponListViewController()
//                    case 1:
//                        subViewController = XFUserCollectionViewController()
//                    case 2:
//                        subViewController = XFUserScoreViewController()
//                    case 3:
//                        subViewController = XFCouponListViewController()
                    default:
                        return
                    }
                }
            } else {
                // 进入登录页面
                subViewController = XFUserLoginViewController()
            }
        }
        // 无需登录的入口
        if section == 3 && row == 0 {            
            // 吐槽建议
            subViewController = XFWebViewController(withUrl: "https://www.10fruits.cn/suggest/suggest.html")
            subViewController?.title = "吐槽建议"
        } else if section == 3 && row == 1 {
            // 品牌介绍
            present(XFAppGuideViewController(), animated: true, completion: nil)
            return
        } else if section == 4 && row == 0 {
            // 设置
            subViewController = XFSettingsViewController()
        }
        else if section == 4 && row == 1{
             navigationController?.pushViewController(XFAboutCompanyViewController(), animated: true)
        }
        if let subViewController = subViewController {
            navigationController?.pushViewController(subViewController, animated: true)
        }
    }
    
}

extension XFUserCenterViewController: UITableViewDataSource,UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 + girdGroupInfo.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if section == 0 {
            return 1
        } else if section == 1 {
            return 2
        } else {
            return girdGroupInfo[section-2].count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 125
        } else if (indexPath.section == 1 && indexPath.row == 1) {
            return 80
        } else {
            return 42
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let section = indexPath.section
        let row = indexPath.row
        if section == 0 {
            let cell = UserCenterAvatarCell(style: .default, reuseIdentifier: "userMainCell")
            cell.user = XFUserGlobal.shared.currentUser
            return cell
        } else if section == 1 {
            if row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: UC_CellIdentifier, for: indexPath)
                cell.textLabel?.text = "你的订单"
                cell.imageView?.image = UIImage.imageWithNamed("mybill")
                return cell
            } else {
                let cell = MyBillTableViewCell(style: .default, reuseIdentifier: "billCell")
                weak var weakSelf = self
                cell.onClicked = {(status,title) in
                    weakSelf?.jumpToOrder(status, title: title)
                }
                return cell
            }
        } else{
            let cell = tableView.dequeueReusableCell(withIdentifier: UC_CellIdentifier, for: indexPath)
            let source = girdGroupInfo[section-2][row]
            cell.textLabel?.text = source["title"]
            cell.imageView?.image = UIImage.imageWithNamed(source["icon"]!)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == girdGroupInfo.count + 2 {
            return nil
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        handleEntrySelect(indexPath: indexPath)
    }
}

class XFUCenterCommonCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    fileprivate func customInit() {
        textLabel?.font = XFConstants.Font.pfn14
        textLabel?.textColor = XFConstants.Color.greyishBrown
        accessoryType = UITableViewCellAccessoryType.disclosureIndicator
    }
}
