//
//  XFOrderDetailViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/8/20.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit

fileprivate let cellIdentifier = "XFOrderDetailGoodsCellIdentifier"

class XFOrderDetailViewController: XFBaseSubViewController {

    var orderId: String?
    
    var detailData: XFOrderDetail?
    
    fileprivate lazy var request: XFOrderSerivice = {
        return XFOrderSerivice()
    }()
    
    fileprivate lazy var detailListView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.separatorColor = XFConstants.Color.separatorLine
        tableView.tableFooterView = UIView()
        tableView.register(XFOrderDetailGoodsCell.self, forCellReuseIdentifier: cellIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "订单详情"
        
        view.addSubview(detailListView)
        detailListView.snp.makeConstraints { (make) in
            make.center.size.equalTo(view)
        }
        
        loadOrderDetail()
    }
    
    fileprivate func loadOrderDetail() {
        if let id = orderId {
            weak var weakSelf = self
            request.getOrderDetail(params: ["orderId":id], { (respData) in
                if let detail = respData as? XFOrderDetail {
                    weakSelf?.detailData = detail
                    weakSelf?.detailListView.reloadData()
                }
            })
        }
    }

    
}

extension XFOrderDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 2
        if let detail = detailData,
            let productList: Array<XFOrderGoodsItem> = detail.productBuyList {
            count += productList.count
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 122
        } else if indexPath.row == 1 {
            return 66
        } else {
            return 110
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: XFOrderDetailHeaderCell = XFOrderDetailHeaderCell.init(style: .default, reuseIdentifier: nil)
            cell.dataSource = detailData
            return cell
        } else if indexPath.row == 1 {
            let cell = XFOrderDetailAddressCell()
            cell.dataSource = detailData?.address
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! XFOrderDetailGoodsCell
            cell.goodsInfo = detailData?.productBuyList![indexPath.row - 2]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
}

