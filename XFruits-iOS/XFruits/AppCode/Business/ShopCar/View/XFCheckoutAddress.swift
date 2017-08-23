//
//  XFCheckoutAddress.swift
//  XFruits
//
//  Created by tangkunyin on 2017/7/28.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit


/// 结算页地址信息
class XFCheckoutAddress: XFAddressesManageTableViewCell {

    var dataSource: XFAddress? {
        didSet {
            if let address = dataSource {
                if let view = self.viewWithTag(99) {
                    view.removeFromSuperview()
                    super.setUpUI()
                    setMyAddress(data: address)
                }
            }
        }
    }
    
    lazy var noDataTip: UITableViewCell = {
        let cell = UITableViewCell()
        cell.tag = 99
        cell.backgroundColor = UIColor.white
        cell.textLabel?.font = XFConstants.Font.pfn14
        cell.textLabel?.textColor = XFConstants.Color.salmon
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.textLabel?.text = "请选择一个有效地址"
        return cell
    }()
        
    override func setUpUI() {
        backgroundColor = UIColor.white
        self.addSubview(noDataTip)
        noDataTip.snp.makeConstraints { (make) in
            make.center.size.equalTo(self)
        }
    }
    
}
