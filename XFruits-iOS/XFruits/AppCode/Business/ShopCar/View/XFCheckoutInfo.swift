//
//  XFCheckoutInfo.swift
//  XFruits
//
//  Created by tangkunyin on 2017/7/28.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit

fileprivate let cellIdentifier = "XFCheckOutInfoCellIdentifier"


class XFCheckoutInfo: UITableView, UITableViewDelegate, UITableViewDataSource {

    lazy var checkoutInfo: Array<Dictionary<String, String>> = {
        return [
            ["title":"商品总价","desc":"¥ 0.00"],
            ["title":"运费","desc":"¥ 0.00"],
            ["title":"优惠券","desc":"¥ 0.00"]
        ]
    }()
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    private func customInit(){
        tableFooterView = UIView()
        bounces = false
        allowsSelection = false
        showsVerticalScrollIndicator = false
        delegate = self
        dataSource = self
        separatorStyle = .none
        register(XFDescriptionItem.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkoutInfo.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for:indexPath) as! XFDescriptionItem
        let info = checkoutInfo[indexPath.row]
        cell.titleLabel.text = info["title"]
        cell.descriptionLabel.text = info["desc"]
        return cell
    }
}
