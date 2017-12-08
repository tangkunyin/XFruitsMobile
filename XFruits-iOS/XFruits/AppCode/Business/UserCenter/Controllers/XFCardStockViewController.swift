//
//  XFCardStockViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/11/20.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit

class XFCardStockViewController: XFNavMenuViewController {

    override var girdGroupInfo: Array<Array<Dictionary<String, String>>> {
        set {}
        get {
            return [
                [
                    ["title":"优惠券", "icon":"myVipCards"],
                    ["title":"积分中心", "icon":"myScore"]
                ]
            ]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "卡劵中心"
        
    }

    override func handleEntrySelect(indexPath: IndexPath) {
        let row = indexPath.row
        var subViewController: UIViewController?
        switch row {
        case 0:
            subViewController = XFCouponListViewController()
        case 1:
            subViewController = XFUserScoreViewController()
        default:
            return
        }
        if let subViewController = subViewController {
            navigationController?.pushViewController(subViewController, animated: true)
        }
    }

}
