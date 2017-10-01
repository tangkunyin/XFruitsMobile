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

class XFUserCenterViewController: XFBaseViewController {
    
    fileprivate lazy var dataSource: NSDictionary = {
        let dataSource: NSDictionary = NSDictionary()
        return dataSource
    }()
        
    lazy var girdGroupInfo: Array<Array<Dictionary<String, String>>> = {
        return [
            [
                ["title":"地址管理", "icon":"myLocation"],
                ["title":"卡券中心", "icon":"myDiscountCoupon"]
            ],
            [
//                ["title":"私人定制", "icon":"aboutme"],
                ["title":"在线客服", "icon":"myService"]
            ],
            [
                ["title":"吐槽建议", "icon":"myAdvice"],
                ["title":"设置", "icon":"app-settings"]
            ],
        ]
    }()
    
    lazy var centerTable: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.separatorColor = XFConstants.Color.separatorLine
        tableView.sectionFooterHeight = 10
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
        tableView.register(XFUCenterCommonCell.self, forCellReuseIdentifier: UC_CellIdentifier)
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
        navigationBar?.isHidden = true
        centerTable.reloadSections(IndexSet(integer: 0), with: .none)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationBar?.isHidden = false
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            centerTable.setValue(2, forKey: "contentInsetAdjustmentBehavior")
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        view.addSubview(centerTable)
        centerTable.snp.makeConstraints({ (make) in
            make.edges.equalTo(view).inset(UIEdgeInsetsMake(0, 0, 0, 0))
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
                } else if section == 2 && row == 0 {
                    // 地址
                    subViewController = XFUserAddressesMangageViewController()
                } else if section == 2 && row == 1 {
                    //TODO 卡劵、优惠券、收藏、积分
                    subViewController = XFCouponListViewController()
                }
            } else {
                // 进入登录页面
                subViewController = XFUserLoginViewController()
            }
        }
        // 无需登录的入口
        if section == 3 && row == 0 {
            //企业通道、私人定制
//            subViewController = XFWebViewController(withUrl: "https://www.10fruits.cn/customization/personal.html")
//            subViewController?.title = "私人定制"
//        } else if section == 3 && row == 1 {
            // 客服
            let chatViewController = createChatViewController(withUser: nil, goodsInfo: nil)
            chatViewController.delegate = self
            subViewController = chatViewController
        } else if section == 4 && row == 0 {
            // 吐槽建议
            subViewController = XFWebViewController(withUrl: "https://www.10fruits.cn/suggest/suggest.html")
            subViewController?.title = "吐槽建议"
        } else if section == 4 && row == 1 {
            // 设置
            subViewController = XFSettingsViewController()
        }
        if let subViewController = subViewController {
            navigationController?.pushViewController(subViewController, animated: true)
        }
    }
    
}

extension XFUserCenterViewController: UITableViewDataSource,UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5;
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
            return 90
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
                cell.textLabel?.text = "我的订单"
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        handleEntrySelect(indexPath: indexPath)
    }
}

extension XFUserCenterViewController: V5ChatViewDelegate {
    /// 客户端连接成功
    func onClientViewConnect() {
        dPrint("客户端连接成功")
    }
    
    /// 会话即将关闭
    func clientViewDidDisappear() {
        dPrint("客户即将离开聊天")
    }
    
    /// 用户将要发送消息
    func userWillSend(_ message: V5Message) -> V5Message {
        // 此处可进行拦截，将客户的会话记录到我方数据库
        dPrint("用户说：\(message.getDefaultContent())")
        return message
    }
    
    /// - 用户在会话中收到消息
    func clientDidReceive(_ message: V5Message) {
        // 我们的客服说了啥
        dPrint("客服说：\(message.getDefaultContent())")
    }
    
    /// - 客户服务状态改变(可在此相应改变对话页标题)
    func clientViewController(_ chatVC: V5ChatViewController, servingStatusChange status: KV5ClientServingStatus) {
        switch status {
        case .ServingStatus_queue,
             .ServingStatus_robot,
             .ServingStatus_inTrust:
            chatVC.title = "云客服服务中"
        case .ServingStatus_worker:
            chatVC.title = "\(V5ClientAgent.shareClient().config?.workerName ?? "小果拾")为您服务"
        
        }
    }
    
}

