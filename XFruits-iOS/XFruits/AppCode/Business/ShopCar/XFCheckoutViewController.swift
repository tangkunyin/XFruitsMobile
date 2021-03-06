//
//  XFCheckoutViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/7/18.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit


fileprivate let XFCheckoutCellReuseIdentifier:String = "XFCheckoutCellReuseIdentifier"

class XFCheckoutViewController: XFBaseSubViewController {

    /// 商品总价，不含运费、邮费、优惠等
    var totalGoodsAmount: Float?
    
    var confirmCoupon: Array<XFCouponItem>?
    
    var confirmAddress: XFAddress? {
        didSet {
            if let address = confirmAddress, let totalPrice = totalGoodsAmount {
                checkoutAddress.dataSource = address
                // 更新优惠券及下单实付金额
                var couponPrice: Float?
                if let couponArr = confirmCoupon, couponArr.count > 0 {
                    couponPrice = couponArr[0].valueFee
                }
                checkoutBar.updateActualAmount(totalAmount: totalPrice, expressFee: address.expressFee)
                checkoutInfo.updateCheckout(InfoArr: [totalGoodsAmount, address.expressFee, couponPrice])
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "确认订单"
        
        makeConstrains()
        updateDataSource()
    }
    
    fileprivate func updateDataSource()  {
        weak var weakSelf = self
        XFOrderSerivice.orderConfirm { (data) in
            if data is XFOrderConfirm {
                let confirm = data as! XFOrderConfirm
                weakSelf?.confirmCoupon = confirm.couponList
                weakSelf?.confirmAddress = confirm.address
            }
        }
    }
    
    func submitOrder() {
        var buyList:Array<Dictionary<String,Any>> = []
        let selectedData: Array<XFCart> = XFCartUtils.sharedInstance.selectedList as! Array<XFCart>
        for item: XFCart in selectedData {
            buyList.append(["productId":item.id! ,"count":item.quantity!])
        }
        guard let address = confirmAddress else {
            showError("您必须选择一个有效的收货地址")
            return
        }
        guard buyList.count > 0 else {
            showError("商品信息为空，请核对后操作")
            return
        }
        weak var weakSelf = self
        let params:[String : Any] = ["productBuyList":buyList, "addressId":address.id, "couponIds":[]]
        XFOrderSerivice.orderCommit(params: params) { (data) in
            let result: XFOrderCommit = data as! XFOrderCommit
            if let orderId = result.orderId,
                let expiration = result.orderExpiration, orderId.count > 0 ,expiration > 0 {
                // 重置果篮已选择的商品
                if XFCartUtils.sharedInstance.clearSelected(carts: selectedData) {
                    let payCenter = XFChoosePayWayViewController()
                    payCenter.title = "请选择付款方式"
                    payCenter.payInfo = result
                    weakSelf?.navigationController?.pushViewController(payCenter, animated: true)
                }
            }
        }
    }
    
    @objc fileprivate func onAddressChange() {
        let addressList = XFAddressListViewController()
        weak var weakSelf = self
        addressList.onSelectedAddress = {(address) in
            weakSelf?.confirmAddress = address
            weakSelf?.checkoutAddress.setMyAddress(data: address)
        }
        navigationController?.pushViewController(addressList, animated: true)
    }

    fileprivate func makeConstrains() {
        view.addSubview(contentView)
        view.addSubview(checkoutBar)
        contentView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(checkoutBar.snp.top)
        }
        checkoutBar.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.height.equalTo(44)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.bottom.equalTo(self.view)
            }
        }
        
        contentView.addSubview(checkoutGoodsListView)
        contentView.addSubview(checkoutAddress)
        contentView.addSubview(checkoutInfo)
        checkoutGoodsListView.snp.makeConstraints { (make) in
            make.height.equalTo(330)
            make.width.top.equalTo(contentView)
        }
        checkoutAddress.snp.makeConstraints { (make) in
            make.height.equalTo(66)
            make.width.equalTo(contentView)
            make.top.equalTo(checkoutGoodsListView.snp.bottom).offset(6)
        }
        checkoutInfo.snp.makeConstraints { (make) in
            make.height.equalTo(120)
            make.width.equalTo(contentView)
            make.top.equalTo(checkoutAddress.snp.bottom).offset(6)
            make.bottom.equalTo(contentView).offset(-6)
        }
    }
    
    fileprivate lazy var contentView: UIScrollView = {
        let content = UIScrollView()
        content.showsVerticalScrollIndicator = false
        content.bounces = false
        content.backgroundColor = XFConstants.Color.separatorLine
        return content
    }()
    
    fileprivate lazy var checkoutGoodsListView:UITableView = {
        let listView = UITableView.init(frame: CGRect.zero, style: .plain)
        listView.delegate = self
        listView.dataSource = self
        listView.allowsSelection = false
        listView.showsVerticalScrollIndicator = false
        listView.backgroundColor = UIColor.white
        listView.separatorColor = XFConstants.Color.separatorLine
        listView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        listView.tableFooterView = UIView()
        listView.register(XFCheckoutGoodsCell.self, forCellReuseIdentifier: XFCheckoutCellReuseIdentifier)
        return listView
    }()
    
    fileprivate lazy var checkoutAddress: XFCheckoutAddress = {
        let addressView = XFCheckoutAddress()
        addressView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onAddressChange)))
        return addressView
    }()
    
    fileprivate lazy var checkoutInfo: XFCheckoutInfo = {
        let infoList = XFCheckoutInfo()
        infoList.InfoArr = [self.totalGoodsAmount, nil, nil]
        return infoList
    }()
    
    fileprivate lazy var checkoutBar:XFCheckoutActionBar = {
        let bar = XFCheckoutActionBar()
        weak var weakSelf = self
        bar.onConfirmBarPress = {
            weakSelf?.submitOrder()
        }
        bar.updateActualAmount(totalAmount: self.totalGoodsAmount!)
        return bar;
    }()
}

extension XFCheckoutViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return XFCartUtils.sharedInstance.selectedList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XFCheckoutCellReuseIdentifier, for: indexPath) as! XFCheckoutGoodsCell
        if let item:XFCart = XFCartUtils.sharedInstance.selectedList[indexPath.row] {
            cell.checkoutSource = item
        }
        return cell
    }
}
