//
//  XFOrderListViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/8/20.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit
import ESPullToRefresh

class XFOrderListViewController: XFBaseSubViewController {

    var orderStatus: String?
    
    var orderData: Array<XFOrderContent> = []
    
    fileprivate var currentPage: Int = 1
    
    fileprivate lazy var orderListView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionFooterHeight = 10
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.separatorColor = XFConstants.Color.separatorLine
        tableView.backgroundColor = XFConstants.Color.separatorLine
        tableView.register(XFOrderTitleItemCell.self, forCellReuseIdentifier: "title")
        tableView.register(XFOrderGoodsItemCell.self, forCellReuseIdentifier: "goods")
        tableView.register(XFOrderBarItemCell.self, forCellReuseIdentifier: "actionBar")
        weak var weakSelf = self
        tableView.es.addPullToRefresh(animator: XFRefreshAnimator.header(), handler: {
            weakSelf?.loadOrderData()
        })
        tableView.es.addInfiniteScrolling(animator: XFRefreshAnimator.footer(), handler: {
            weakSelf?.loadOrderData(true)
        })
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.title == nil || self.title == "" {
            self.title = "我的订单"
        }
        
        renderLoaddingView()
        loadOrderData()
    }

    fileprivate func loadOrderData(_ loadMore: Bool = false) {
        weak var weakSelf = self
        var params: Dictionary<String, Any> = ["page":currentPage,"size":XFConstants.pageRows]
        if let status = orderStatus {
            params.updateValue(status, forKey: "status")
        }
        XFOrderSerivice.getOrderList(params: params) { (respData) in
            weakSelf?.orderListView.es.stopLoadingMore()
            weakSelf?.orderListView.es.stopPullToRefresh()
            if let order = respData as? XFOrder, let orderList = order.content, orderList.count > 0 {
                weakSelf?.currentPage += 1
                if loadMore {
                    weakSelf?.orderData += orderList
                    weakSelf?.renderOrderListView(data: weakSelf?.orderData)
                } else {
                    weakSelf?.renderOrderListView(data: orderList)
                }
            } else {
                if weakSelf?.currentPage == 1 {
                    weakSelf?.orderListView.removeFromSuperview()
                    weakSelf?.renderNullDataView()
                } else {
                    weakSelf?.orderListView.es.noticeNoMoreData()
                }
            }
        }
    }
    
    fileprivate func renderOrderListView(data: Array<XFOrderContent>?){
        if let data = data {
            self.orderData = data
            view.addSubview(orderListView)
            orderListView.snp.makeConstraints { (make) in
                make.center.size.equalTo(view)
            }
        }
    }
    
    // 订单内继续完成支付
    fileprivate func orderPayWith(order: XFOrderContent){
        let payInfo = XFOrderCommit()
        payInfo.orderId = order.orderId
        payInfo.cashFee = "\(order.cashFee)"
        payInfo.orderExpiration = order.orderExpiration
        // TODO. 支付频道接口没有数据，此处手动造支付频道数据，如果接口返回了，则用接口数据
        let alipayChannel = XFPayChannel()
        alipayChannel.name = "支付宝"
        alipayChannel.channel = 1
        alipayChannel.defaultChannel = true
        let wxpayChannel = XFPayChannel()
        wxpayChannel.name = "微信"
        wxpayChannel.channel = 2
        wxpayChannel.defaultChannel = false
        payInfo.payChannels = [alipayChannel, wxpayChannel]
        let payCenter = XFChoosePayWayViewController()
        payCenter.payInfo = payInfo
        navigationController?.pushViewController(payCenter, animated: true)
    }
    
    // 确认收货
    fileprivate func orderConfirm(withOrderId orderId: String){
        weak var weakSelf = self
        XFOrderSerivice.confirmOrder(params: ["orderId":orderId]) { (data) in
            weakSelf?.showMessage("收货成功，感谢支持", completion: {
                weakSelf?.loadOrderData()
            })
        }
    }
    
    fileprivate func queryExpress(withOrderId orderId: String){
        let expressVC = XFExpressViewController()
        expressVC.orderId = orderId
        navigationController?.pushViewController(expressVC, animated: true)
    }
    
    fileprivate func orderComment(withOrder order: XFOrderContent) {
        let commentVC = XFCommentViewController()
        commentVC.order = order
        navigationController?.pushViewController(commentVC, animated: true)
    }
    
    fileprivate func barClickHandler(_ type: Int, _ orderData: XFOrderContent){
        switch type {
        case 0:
            orderPayWith(order: orderData)
        case 1:
            queryExpress(withOrderId: orderData.orderId)
        case 2:
            orderConfirm(withOrderId: orderData.orderId)
        case 3:
            orderComment(withOrder: orderData)
        default:
            break
        }
    }
}

extension XFOrderListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return orderData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let products = orderData[section].productList {
            return products.count + 2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == orderData.count - 1 {
            return 0
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let products = orderData[indexPath.section].productList {
            if indexPath.row == 0 {
                return 40
            } else if indexPath.row == products.count + 1 {
                return 40
            } else {
                return 110
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let products = orderData[indexPath.section].productList {
            if indexPath.row == 0,
                let cell = tableView.dequeueReusableCell(withIdentifier: "title") as? XFOrderTitleItemCell {
                cell.dataSource = orderData[indexPath.section]
                return cell
            } else if indexPath.row == products.count + 1,
                let cell = tableView.dequeueReusableCell(withIdentifier: "actionBar") as? XFOrderBarItemCell {
                cell.dataSource = orderData[indexPath.section]
                weak var weakSelf = self
                cell.onBarBtnClick = {(type, data) in
                    weakSelf?.barClickHandler(type, data)
                }
                return cell
            } else if products.count > 0, products.count > indexPath.row - 1,
                let cell = tableView.dequeueReusableCell(withIdentifier: "goods") as? XFOrderGoodsItemCell {
                cell.goodsInfo = products[indexPath.row - 1]
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let orderDetail = XFOrderDetailViewController()
        orderDetail.orderId = orderData[indexPath.section].orderId
        navigationController?.pushViewController(orderDetail, animated: true)
    }
}

