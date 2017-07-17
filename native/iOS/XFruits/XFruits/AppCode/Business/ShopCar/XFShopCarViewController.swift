//
//  XFShopCarViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import MBProgressHUD

fileprivate let XFCartCellReuseIdentifier:String = "XFShopCartCellReuseIdentifier"

class XFShopCarViewController: XFBaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    var cartList:Array<XFCart?> = []
    
    var shopCartViewCount: Int = 0
    
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
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "编辑",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(onShopCartEdit))
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadShopCartData),
                                               name: NSNotification.Name(rawValue: XFConstants.MessageKey.NeedRefreshShopCartData),
                                               object: nil)
    }
    

    @objc private func onShopCartEdit(){
        
        
        
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
    @objc private func reloadShopCartData() {
        cartList = XFCartUtils.sharedInstance.getAll()
        if cartList.count > 0 {
            shopCartViewCount = 0
            cartEmptyView.alpha = 0
            cartListView.alpha = 1
            actionBar.alpha = 1
            cartListView.reloadData()
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
        listView.register(XFShopCartViewCell.self, forCellReuseIdentifier: XFCartCellReuseIdentifier)
        listView.tableFooterView = UIView()
        return listView
    }()
    
    private lazy var cartEmptyView: XFShopCartEmptyView = {
        let emptyView = XFShopCartEmptyView()
        return emptyView
    }()
    
    private lazy var actionBar:XFShopCartActionBar = {
        let bar = XFShopCartActionBar()
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

