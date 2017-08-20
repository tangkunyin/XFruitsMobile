//
//  XFOrderListViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/8/20.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit

fileprivate let cellIdentifier = "XFOrderListCellIdentifier"

class XFOrderListViewController: XFBaseSubViewController {

    var orderStatus: String?
    
    var orderData: Array<XFOrderContent>?
    
    lazy var request: XFOrderSerivice = {
        return XFOrderSerivice()
    }()
    
    private lazy var orderListView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.separatorColor = XFConstants.Color.separatorLine
        tableView.tableFooterView = UIView()
        tableView.register(XFOrderListItem.self, forCellReuseIdentifier: cellIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(orderListView)
        orderListView.snp.makeConstraints { (make) in
            make.center.size.equalTo(view)
        }
        
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
                let orderList = order.content {
                weakSelf?.orderData = orderList
                weakSelf?.orderListView.reloadData()
            }
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! XFOrderListItem
        cell.selectionStyle = .none
        if let orderData = orderData {
            cell.dataSource = orderData[indexPath.row]
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

