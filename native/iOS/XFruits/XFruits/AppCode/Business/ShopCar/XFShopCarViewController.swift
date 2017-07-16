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
    
    lazy var cartListView:UITableView = {
        let listView = UITableView.init(frame: CGRect.zero, style: .plain)
        listView.delegate = self
        listView.dataSource = self
        listView.backgroundColor = UIColor.white
        listView.register(XFShopCartViewCell.self, forCellReuseIdentifier: XFCartCellReuseIdentifier)
        return listView
    }()
    
    lazy var cartEmptyView: XFShopCartEmptyView = {
        let emptyView = XFShopCartEmptyView()
        return emptyView
    }()
    
    lazy var actionBar:XFShopCartActionBar = {
        let bar = XFShopCartActionBar()
        return bar;
    }()
    
    
    lazy var cartList:Array<XFCart?> = {
        let list = XFCartUtils.sharedInstance.getAll()
        return list
    }()
    
    lazy var shopCartViewCount: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "编辑",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(onShopCartEdit))
        
        view.addSubview(cartEmptyView)
        view.addSubview(cartListView)
        view.addSubview(actionBar)
        makeContentViewConstrains()
    }
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: XFCartCellReuseIdentifier, for: indexPath)
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell:XFShopCartViewCell = tableView.cellForRow(at: indexPath) as! XFShopCartViewCell
        cell.radioBtn.isSelected = !cell.radioBtn.isSelected
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    

}

