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

class XFShopCarViewController: XFBaseViewController {
    
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
        guard selectedTotalAmount > 0 else {
            MBProgressHUD.showError("结算总价有误，请检查")
            return
        }
        guard XFUserGlobal.shared.isLogin else {
            // 进入登录页面
            let login = XFUserLoginViewController()
            let nav = UINavigationController.init(rootViewController: login)
            present(nav, animated: true, completion: nil)
            return
        }
        let checkoutVC = XFCheckoutViewController()
        checkoutVC.totalGoodsAmount = selectedTotalAmount
        navigationController?.pushViewController(checkoutVC, animated: true)
    }

    // MARK: - Cart fileprivate func and variables
    fileprivate func calculateTotalAmount() {
        let selectedData: Array<XFCart> = XFCartUtils.sharedInstance.selectedList as! Array<XFCart>
        selectedItemCount = selectedData.count
        selectedTotalAmount = 0
        for cart: XFCart in selectedData {
            if let count = cart.quantity, let price = cart.primePrice {
                selectedTotalAmount += Float(Double(count) * price)
            }
        }
        actionBar.update(total: selectedItemCount, amount: selectedTotalAmount)
    }
    
    
    @objc fileprivate func reloadShopCartData() {
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
    
    
    fileprivate lazy var cartListView:UITableView = {
        let listView = UITableView.init(frame: CGRect.zero, style: .plain)
        listView.delegate = self
        listView.dataSource = self
        listView.rowHeight = 110
        listView.backgroundColor = UIColor.white
        listView.tableFooterView = UIView()
        listView.separatorColor = XFConstants.Color.separatorLine
        listView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        listView.showsVerticalScrollIndicator = false
        listView.register(XFShopCartViewCell.self, forCellReuseIdentifier: XFCartCellReuseIdentifier)
        return listView
    }()
    
    fileprivate lazy var cartEmptyView: XFShopCartEmptyView = {
        let emptyView = XFShopCartEmptyView()
        return emptyView
    }()
    
    fileprivate lazy var actionBar:XFShopCartActionBar = {
        let bar = XFShopCartActionBar()
        weak var weakSelf = self
        bar.onConfirmBarPress = {
            weakSelf?.checkoutShopCart()
        }
        return bar;
    }()
    
    fileprivate func makeContentViewConstrains(){
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

extension XFShopCarViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XFCartCellReuseIdentifier, for: indexPath) as! XFShopCartViewCell
        if let item:XFCart = cartList[indexPath.row] {
            cell.dataSource = item
        }
        // 注册3D Touch
        if self.traitCollection.forceTouchCapability == UIForceTouchCapability.available {
            self.registerForPreviewing(with: self, sourceView: cell)
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
}

extension XFShopCarViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        if let indexPath: IndexPath = self.cartListView.indexPath(for: (previewingContext.sourceView as! XFShopCartViewCell))
            ,let item:XFCart = self.cartList[indexPath.row] {
            let detailVC = XFDetailViewController()
            detailVC.prodId = item.id
            return detailVC
        }
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }
}
