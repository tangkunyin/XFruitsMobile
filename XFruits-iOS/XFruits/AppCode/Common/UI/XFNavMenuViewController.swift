//
//  XFNavMenuViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/11/20.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit

fileprivate let XFNavMenuCellIdentifier = "XFNavMenuCellIdentifier"

class XFNavMenuCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    fileprivate func customInit() {
        textLabel?.font = XFConstants.Font.pfn14
        textLabel?.textColor = XFConstants.Color.greyishBrown
        accessoryType = UITableViewCellAccessoryType.disclosureIndicator
    }
}

class XFNavMenuViewController: XFBaseSubViewController {

    // 子类重写此属性，提供数据源
    var girdGroupInfo: Array<Array<Dictionary<String, String>>> = [[]]
    
    lazy var menuListView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionFooterHeight = 8
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.separatorColor = XFConstants.Color.separatorLine
        tableView.backgroundColor = XFConstants.Color.separatorLine
        tableView.register(XFNavMenuCell.self, forCellReuseIdentifier: XFNavMenuCellIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(menuListView)
        menuListView.snp.makeConstraints({ (make) in
            make.center.size.equalTo(view)
        })
    }

    
    func handleEntrySelect(indexPath: IndexPath) {
        // 细节交给子类实现
    }
}

extension XFNavMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return girdGroupInfo.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return girdGroupInfo[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 42
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XFNavMenuCellIdentifier, for: indexPath)
        let source = girdGroupInfo[indexPath.section][indexPath.row]
        cell.textLabel?.text = source["title"]
        cell.imageView?.image = UIImage.imageWithNamed(source["icon"]!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == girdGroupInfo.count {
            return nil
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        handleEntrySelect(indexPath: indexPath)
    }
    
}
