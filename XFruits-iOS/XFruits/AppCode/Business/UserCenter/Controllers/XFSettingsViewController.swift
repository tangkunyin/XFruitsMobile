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

/// 设置中心，版本号
class XFSettingsViewController: XFBaseSubViewController {

    fileprivate lazy var settingsDataSource: Array<Array<Dictionary<String, String>>> = {
        return [
            [
                ["key":"版本号","value":getLocalVersion()],
                ["key":"清理缓存","value":""],
            ],
            [
                ["key":"点个赞","value":XFConstants.storeUrl],
                ["key":"私人订制","value":""],
                ["key":"关于我们","value":"about"]
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
        } else if "清理缓存" == key {
            showSuccess("拾个农夫兴奋的提示您：清理完成")
        } else if "私人订制" == key {
            if let sessionViewController = createChatViewController(title: "个人中心#私人订制") {
                navigationController?.pushViewController(sessionViewController, animated: true)
            } else {
                showError("抱歉老板，客服暂时联系不上...")
            }
        } else if "关于我们" == key {
            navigationController?.pushViewController(XFAboutCompanyViewController(), animated: true)
        }
    }
    
}
