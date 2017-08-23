//
//  XFOrderListViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/8/20.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD

fileprivate let cellIdentifier = "XFOrderListCellIdentifier"

class XFOrderListViewController: XFBaseSubViewController {

    var orderStatus: String?
    
    fileprivate var orderData: Array<XFOrderContent>?
    
    fileprivate lazy var request: XFOrderSerivice = {
        return XFOrderSerivice()
    }()
    
    private lazy var orderListView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.separatorColor = XFConstants.Color.separatorLine
        tableView.rowHeight = 136
        tableView.register(XFOrderListItem.self, forCellReuseIdentifier: cellIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderLoaddingView()
        loadOrderData()
    }

    private func loadOrderData() {
        weak var weakSelf = self
        var params: Dictionary<String, Any> = ["page":1,"size":10]
        if let status = orderStatus {
            params.updateValue(status, forKey: "status")
        }
        request.getOrderList(params: params) { (respData) in
            if let order = respData as? XFOrder,
                let orderList = order.content, orderList.count > 0 {
                weakSelf?.renderOrderListView(data: orderList)
            } else {
                weakSelf?.orderListView.removeFromSuperview()
                weakSelf?.renderNullDataView()
            }
        }
    }
    
    private func renderOrderListView(data: Array<XFOrderContent>){
        self.orderData = data
        view.addSubview(orderListView)
        orderListView.snp.makeConstraints { (make) in
            make.center.size.equalTo(view)
        }
    }
    
    //TODO. 订单内继续完成支付
    private func orderPay(){
        
    }
    
    // 确认收货
    private func orderConfirmWith(orderId: String){
        weak var weakSelf = self
        request.confirmOrder(params: ["orderId":orderId]) { (data) in
            MBProgressHUD.showMessage("收货成功，感谢支持", completion: {
                weakSelf?.loadOrderData()
            })
        }
    }
    
    private func queryExpressWith(orderId: String){
        let expressVC = XFExpressViewController()
        expressVC.orderId = orderId
        navigationController?.pushViewController(expressVC, animated: true)
    }
    
    private func barClickHandler(_ type: Int, _ orderData: XFOrderContent){
        switch type {
        case 0:
            orderPay()
        case 1:
            queryExpressWith(orderId: orderData.orderId)
        case 2:
            orderConfirmWith(orderId: orderData.orderId)
        case 3:
            //TODO. 订单评价
            MBProgressHUD.showSuccess("已收到帅帅的你滴好评咯~")
        default:
            break
        }
    }
}

extension XFOrderListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let orderData = orderData {
            return orderData.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! XFOrderListItem
        cell.selectionStyle = .none
        if let orderData = orderData {
            cell.dataSource = orderData[indexPath.row]
            weak var weakSelf = self
            cell.onBarBtnClick = {(type, data) in
                weakSelf?.barClickHandler(type, data)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if let orderData = orderData {
            let orderDetail = XFOrderDetailViewController()
            orderDetail.orderId = orderData[indexPath.row].orderId
            navigationController?.pushViewController(orderDetail, animated: true)
        }
    }
}

