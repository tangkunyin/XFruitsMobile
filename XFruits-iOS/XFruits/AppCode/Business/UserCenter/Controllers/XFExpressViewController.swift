//
//  XFExpressViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/8/20.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit

fileprivate let cellIdentifier = "XFOrderExpressInfoCellIdentifier"

fileprivate let indicatorFrame = CGRect(origin: CGPoint.zero, size: CGSize(width: 24, height: 24))
fileprivate let normalIndicator = UIImage.imageWithNamed("point_gray")
fileprivate let hightLightIndicator = UIImage.imageWithNamed("point_green_right")


class XFExpressViewController: XFBaseSubViewController {

    var orderId: String = ""
    
    var expressData: XFExpress?
    
    fileprivate lazy var expressInfoHeader: UIView = {
        let header = UIView()
        header.backgroundColor = UIColor.white
        header.addSubview(self.expressName)
        header.addSubview(self.deliveryNum)
        header.addSubview(self.deliveryNumCopyBtn)
        weak var weakSelf = self
        self.expressName.snp.makeConstraints({ (make) in
            make.top.equalTo(header).offset(5)
            make.left.equalTo(header).offset(10)
            make.height.equalTo(25)
            make.right.equalTo((weakSelf?.deliveryNumCopyBtn.snp.left)!).offset(-10)
        })
        self.deliveryNum.snp.makeConstraints({ (make) in
            make.left.right.height.equalTo((weakSelf?.expressName)!)
            make.top.equalTo((weakSelf?.expressName.snp.bottom)!).offset(5)
            make.bottom.equalTo(header).offset(-5)
        })
        self.deliveryNumCopyBtn.snp.makeConstraints({ (make) in
            make.centerY.equalTo(header)
            make.size.equalTo(CGSize(width: 70, height: 30))
            make.right.equalTo(header).offset(-10)
        })
        return header
    }()
    
    fileprivate lazy var expressName: UILabel = {
        let label = UILabel()
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        return label
    }()
    
    fileprivate lazy var deliveryNum: UILabel = {
        let label = UILabel()
        label.font = XFConstants.Font.pfn14
        label.textColor = XFConstants.Color.darkGray
        return label
    }()
    
    fileprivate lazy var deliveryNumCopyBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("复制单号", for: .normal)
        btn.setTitleColor(XFConstants.Color.darkGray, for: .normal)
        btn.titleLabel?.font = XFConstants.Font.pfn14
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = XFConstants.UI.singleLineAdjustOffset
        btn.layer.borderColor = XFConstants.Color.darkGray.cgColor
        btn.addTarget(self, action: #selector(copyDeliveryNum), for: .touchUpInside)
        return btn
    }()
    
    
    fileprivate lazy var expressListView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.separatorColor = XFConstants.Color.separatorLine
        tableView.tableFooterView = UIView()
        tableView.sectionHeaderHeight = 65
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "快递信息"
        renderLoaddingView()
        loadExpressData()
    }
    
    fileprivate func loadExpressData() {
        weak var weakSelf = self
        XFOrderSerivice.getExpressDetail(params: ["orderId":orderId]) { (respData) in
            if let express = respData as? XFExpress,
                let traceInfo = express.trackingInfoList, traceInfo.count > 0 {
                weakSelf?.expressData = express
                weakSelf?.renderExpressListView()
            } else {
                weakSelf?.renderNullDataView()
            }
        }
    }
    
    fileprivate func renderExpressListView(){
        expressName.text = "物流信息：\(expressData?.expressName ?? "未知")"
        deliveryNum.text = "快递单号：\(expressData?.trackingNum ?? "未知")"
        view.addSubview(expressListView)
        expressListView.snp.makeConstraints { (make) in
            make.center.size.equalTo(view)
        }
    }

    @objc fileprivate func copyDeliveryNum(){
        if let express = expressData, express.trackingNum.count > 0 {
            UIPasteboard.general.string = express.trackingNum
            showSuccess("复制成功")
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return expressInfoHeader
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: cellIdentifier)
            cell?.selectionStyle = .none
        }
        if let express = expressData,
            let traceList: Array<XFExpressUnit> = express.trackingInfoList {
            let traceInfo = traceList[indexPath.row]
            
            cell?.imageView?.image = indexPath.row == 0 ? hightLightIndicator : normalIndicator
            // 改变默认图片大小
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 24, height: 24), false, UIScreen.main.scale)
            cell!.imageView?.image!.draw(in: indicatorFrame)
            cell!.imageView?.image! = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            cell!.textLabel?.font = XFConstants.Font.pfn14
            cell!.textLabel?.textColor = indexPath.row == 0 ? XFConstants.Color.green : XFConstants.Color.darkGray
            cell!.textLabel?.numberOfLines = 0
            cell!.textLabel?.lineBreakMode = .byWordWrapping
            cell!.textLabel?.text = traceInfo.info
            
            cell!.detailTextLabel?.font = XFConstants.Font.pfn12
            cell!.detailTextLabel?.textColor = XFConstants.Color.coolGrey
            cell!.detailTextLabel?.text = traceInfo.time
        }
        return cell!
    }
    
}


