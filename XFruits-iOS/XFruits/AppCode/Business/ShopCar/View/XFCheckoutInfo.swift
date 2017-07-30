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

    lazy var InfoArr: Array<Float?> = {
        return [0.00 ,0.00 ,0.00]
    }()
    
    func updateCheckout(InfoArr: Array<Float?>)  {
        self.InfoArr = InfoArr
        reloadData()
    }
    
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
        separatorColor = XFConstants.Color.separatorLine
        separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        register(XFDescriptionItem.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return InfoArr.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for:indexPath) as! XFDescriptionItem
        let row = indexPath.row
        switch row {
        case 0:
            cell.titleLabel.text = "商品总价"
        case 1:
            cell.titleLabel.text = "运费"
        case 2:
            cell.titleLabel.text = "优惠券"
        default:
            break
        }
        if let price  = InfoArr[row] {
            cell.descriptionLabel.text = String(format:"¥ %.2f", price)
        } else {
            cell.descriptionLabel.text = "¥ 0.00"
        }
        return cell
    }
}
