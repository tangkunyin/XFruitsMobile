//
//  XFShopCarViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import MBProgressHUD
import SnapKit

fileprivate let XFCartCellReuseIdentifier:String = "XFShopCartCellReuseIdentifier"

class XFShopCarViewController: XFBaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    var cartList:Array<XFCart?> = []
    
    var shopCartViewCount: Int = 0
    
    var selectedItemCount: Int = 0
    
    var selectedTotalAmount: Float = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadShopCartData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(cartEmptyView)
        view.addSubview(cartListView)
        view.addSubview(actionBar)
        makeContentViewConstrains()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadShopCartData),
                                               name: NSNotification.Name(rawValue: XFConstants.MessageKey.NeedRefreshShopCartData),
                                               object: nil)
    }
    
    fileprivate func checkoutShopCart() {
        guard selectedItemCount > 0 else {
            MBProgressHUD.showError("请至少选择一项下单")
            return
        }
        let checkoutVC = XFCheckoutViewController()
        checkoutVC.totalGoodsAmount = selectedTotalAmount
        navigationController?.pushViewController(checkoutVC, animated: true)
    }

    
    // MARK: - Cart Tableview delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XFCartCellReuseIdentifier, for: indexPath) as! XFShopCartViewCell
        if let item:XFCart = cartList[indexPath.row] {
            cell.dataSource = item
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let item:XFCart = cartList[indexPath.row] {
            let cell:XFShopCartViewCell = tableView.cellForRow(at: indexPath) as! XFShopCartViewCell
            let checked = !cell.radioBtn.isSelected
            if XFCartUtils.sharedInstance.selectItem(gid: item.id, checked: checked) {
                cell.radioBtn.isSelected = checked
                reloadShopCartData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if let item:XFCart = cartList[indexPath.row], editingStyle == .delete {
            if XFCartUtils.sharedInstance.deleteItem(gid: item.id) {
                reloadShopCartData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    

    // MARK: - Cart private func and variables
    private func calculateTotalAmount() {
        let selectedData: Array<XFCart> = XFCartUtils.sharedInstance.selectedList as! Array<XFCart>
        selectedItemCount = selectedData.count
        selectedTotalAmount = 0
        for cart: XFCart in selectedData {
            if let count = cart.quantity, let price = cart.salesPrice {
                selectedTotalAmount += Float(Double(count) * price)
            }
        }
        actionBar.update(total: selectedItemCount, amount: selectedTotalAmount)
    }
    
    
    @objc private func reloadShopCartData() {
        cartList = XFCartUtils.sharedInstance.getAll()
        if cartList.count > 0 {
            shopCartViewCount = 0
            cartEmptyView.alpha = 0
            cartListView.alpha = 1
            actionBar.alpha = 1
            cartListView.reloadData()
            calculateTotalAmount()
        } else {
            shopCartViewCount += 1
            cartEmptyView.alpha = 1
            cartListView.alpha = 0
            actionBar.alpha = 0
            cartEmptyView.viewCount = shopCartViewCount
        }
    }
    
    
    private lazy var cartListView:UITableView = {
        let listView = UITableView.init(frame: CGRect.zero, style: .plain)
        listView.delegate = self
        listView.dataSource = self
        listView.backgroundColor = UIColor.white
        listView.tableFooterView = UIView()
        listView.showsVerticalScrollIndicator = false
        listView.register(XFShopCartViewCell.self, forCellReuseIdentifier: XFCartCellReuseIdentifier)
        return listView
    }()
    
    private lazy var cartEmptyView: XFShopCartEmptyView = {
        let emptyView = XFShopCartEmptyView()
        return emptyView
    }()
    
    private lazy var actionBar:XFShopCartActionBar = {
        let bar = XFShopCartActionBar()
        weak var weakSelf = self
        bar.onConfirmBarPress = {
            weakSelf?.checkoutShopCart()
        }
        return bar;
    }()
    
    private func makeContentViewConstrains(){
        cartEmptyView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self.view)
        }
        cartListView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.actionBar.snp.top).offset(0)
        }
        actionBar.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.equalTo(self.cartListView.snp.bottom).offset(0)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
    }
}

