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

class XFCheckoutViewController: XFBaseViewController,UITableViewDelegate,UITableViewDataSource {

    
    /// 商品总价，不含运费、邮费、优惠等
    var totalGoodsAmount: Float?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "确认订单"
    
        view.addSubview(checkoutGoodsListView)
        view.addSubview(checkoutBar)
        
        checkoutGoodsListView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(330)
        }
        checkoutBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(40)
        }
        
        checkoutBar.update(amount: totalGoodsAmount!)
    }
    
    // MARK: - Cart Tableview delegates
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
    

    func submitOrder() {
        dPrint("submit order...")
    }

    private lazy var checkoutGoodsListView:UITableView = {
        let listView = UITableView.init(frame: CGRect.zero, style: .plain)
        listView.delegate = self
        listView.dataSource = self
        listView.allowsSelection = false
        listView.bounces = false
        listView.backgroundColor = UIColor.white
        listView.tableFooterView = UIView()
        listView.showsVerticalScrollIndicator = false
        listView.register(XFCheckoutGoodsCell.self, forCellReuseIdentifier: XFCheckoutCellReuseIdentifier)
        return listView
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
