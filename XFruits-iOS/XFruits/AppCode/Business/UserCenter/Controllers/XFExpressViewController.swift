//
//  XFExpressViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/8/20.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit

fileprivate let cellIdentifier = "XFOrderExpressInfoCellIdentifier"

class XFExpressViewController: XFBaseSubViewController {

    var orderId: String = ""
    
    fileprivate var expressData: XFExpress?
    
    fileprivate lazy var request: XFOrderSerivice = {
        return XFOrderSerivice()
    }()
    
    private lazy var expressListView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.separatorColor = XFConstants.Color.separatorLine
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "快递信息"
        renderLoaddingView()
        loadExpressData()
    }
    
    private func loadExpressData() {
        weak var weakSelf = self
        request.getExpressDetail(params: ["orderId":orderId]) { (respData) in
            if let express = respData as? XFExpress,
                let traceInfo = express.trackingInfoList, traceInfo.count > 0 {
                weakSelf?.expressData = express
                weakSelf?.renderExpressListView()
            } else {
                weakSelf?.renderNullDataView()
            }
        }
    }
    
    private func renderExpressListView(){
        view.addSubview(expressListView)
        expressListView.snp.makeConstraints { (make) in
            make.center.size.equalTo(view)
        }
    }

}

extension XFExpressViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let express = expressData,
            let traceInfo = express.trackingInfoList {
            return traceInfo.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: cellIdentifier)
        if let express = expressData,
            let traceList: Array<XFExpressUnit> = express.trackingInfoList {
            let traceInfo = traceList[indexPath.row]
            
            cell.textLabel?.font = XFConstants.Font.pfn14
            cell.textLabel?.textColor = XFConstants.Color.darkGray
            cell.textLabel?.text = traceInfo.info
            
            cell.detailTextLabel?.font = XFConstants.Font.pfn12
            cell.detailTextLabel?.textColor = XFConstants.Color.coolGrey
            cell.detailTextLabel?.text = traceInfo.time
        }
        return cell
    }
    
}


