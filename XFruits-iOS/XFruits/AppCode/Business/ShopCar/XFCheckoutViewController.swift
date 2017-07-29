//
//  XFCheckoutViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/7/18.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD


fileprivate let XFCheckoutCellReuseIdentifier:String = "XFCheckoutCellReuseIdentifier"

class XFCheckoutViewController: XFBaseViewController {

    
    /// 商品总价，不含运费、邮费、优惠等
    var totalGoodsAmount: Float?
    
    lazy var request:XFCommonService = {
        let serviceRequest = XFCommonService()
        return serviceRequest
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "确认订单"
    
        view.addSubview(contentView)
        view.addSubview(checkoutBar)
        contentView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(checkoutBar.snp.top)
        }
        checkoutBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(44)
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
            make.top.equalTo(checkoutGoodsListView.snp.bottom).offset(5)
        }
        checkoutInfo.snp.makeConstraints { (make) in
            make.height.equalTo(120)
            make.width.equalTo(contentView)
            make.top.equalTo(checkoutAddress.snp.bottom).offset(5)
            make.bottom.equalTo(contentView).offset(-5)
        }
        
        updateDataSource()
    }
    
    private func updateDataSource()  {
        checkoutBar.update(amount: totalGoodsAmount!)
        request.orderConfirm { (data) in
            
        }
    }
    
    func submitOrder() {
        dPrint("submit order...")
    }

    private lazy var contentView: UIScrollView = {
        let content = UIScrollView()
        content.showsVerticalScrollIndicator = false
        content.bounces = false
        content.backgroundColor = XFConstants.Color.separatorLine
        return content
    }()
    
    private lazy var checkoutGoodsListView:UITableView = {
        let listView = UITableView.init(frame: CGRect.zero, style: .plain)
        listView.delegate = self
        listView.dataSource = self
        listView.allowsSelection = false
        listView.showsVerticalScrollIndicator = false
        listView.backgroundColor = UIColor.white
        listView.separatorStyle = .none
        listView.tableFooterView = UIView()
        listView.register(XFCheckoutGoodsCell.self, forCellReuseIdentifier: XFCheckoutCellReuseIdentifier)
        return listView
    }()
    
    private lazy var checkoutAddress: XFCheckoutAddress = {
        let addressView = XFCheckoutAddress()
        return addressView
    }()
    
    private lazy var checkoutInfo: XFCheckoutInfo = {
        let infoList = XFCheckoutInfo()
        return infoList
    }()
    
    private lazy var checkoutBar:XFCheckoutActionBar = {
        let bar = XFCheckoutActionBar()
        weak var weakSelf = self
        bar.onConfirmBarPress = {
            weakSelf?.submitOrder()
        }
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
