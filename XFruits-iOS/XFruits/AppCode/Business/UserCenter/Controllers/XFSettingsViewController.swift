//
//  XFSettingsViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/8/20.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit

fileprivate let cellIdentifier = "XFSettingsCellIdentifier"

/// 设置中心，版本号，关于我们
class XFSettingsViewController: XFBaseSubViewController {

    fileprivate lazy var settingsDataSource: Array<Array<Dictionary<String, String>>> = {
        return [
            [
                ["key":"版本号","value":"1.0.1"],
                ["key":"点个赞","value":XFConstants.storeUrl],
            ],
            [
                ["key":"关于我们","value":""],
            ]
        ]
    }()
    
    
    fileprivate lazy var settingListView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.separatorColor = XFConstants.Color.separatorLine
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 44
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "设置中心"
        view.addSubview(settingListView)
        settingListView.snp.makeConstraints { (make) in
            make.center.size.equalTo(view)
        }
    }

}

extension XFSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsDataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsDataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        cell!.textLabel?.font = XFConstants.Font.pfn14
        cell!.textLabel?.textColor = XFConstants.Color.darkGray
        
        let data = settingsDataSource[indexPath.section][indexPath.row]
        
        if indexPath.section == 0 && indexPath.row == 0 {
            cell?.textLabel?.text = "\(data["key"] ?? "")：\(data["value"] ?? "")"
        } else {
            cell?.textLabel?.text = data["key"]
        }

        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let key = settingsDataSource[indexPath.section][indexPath.row]["key"]
        if "点个赞" == key {
            UIApplication.shared.openURL(URL(string:XFConstants.storeUrl)!)
        } else if "关于我们" == key {
            let aboutus = XFAboutCompanyViewController()
            navigationController?.pushViewController(aboutus, animated: true)
        }
    }
    
}
