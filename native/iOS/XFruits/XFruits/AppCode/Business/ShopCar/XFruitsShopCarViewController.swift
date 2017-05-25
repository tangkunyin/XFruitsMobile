//
//  XFruitsShopCarViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/4/9.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import MBProgressHUD

fileprivate let XFCartCellReuseIdentifier:String = "XFShopCartCellReuseIdentifier"

class XFruitsShopCarViewController: XFruitsBaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    lazy var cartListView:UITableView = {
        let listView = UITableView.init(frame: CGRect.zero, style: .plain)
        listView.delegate = self
        listView.dataSource = self
        listView.backgroundColor = UIColor.white
        listView.register(XFShopCartViewCell.self, forCellReuseIdentifier: XFCartCellReuseIdentifier)
        return listView
    }()
    
    
    lazy var actionBar:XFShopCartActionBar = {
        let bar = XFShopCartActionBar()
        return bar;
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "编辑",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(onShopCartEdit))
        view.addSubview(cartListView)
        view.addSubview(actionBar)
        makeViewConstrains()
    }
    
    fileprivate func makeViewConstrains(){
        cartListView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.actionBar.snp.top).offset(-5)
        }
        actionBar.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.equalTo(self.cartListView.snp.bottom).offset(5)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
    }

    
    @objc private func onShopCartEdit(){
        MBProgressHUD.showError("您有毛线可编辑吗？")
    }
    
    
    // MARK: - Cart Tableview delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XFCartCellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = "\(indexPath.row) - 行"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    

}
