//
//  XFOrderDetailHeaderCell.swift
//  XFruits
//
//  Created by tangkunyin on 2017/8/20.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit

class XFOrderDetailHeaderCell: UITableViewCell {

    var dataSource: XFOrderDetail? {
        didSet {
            if let detail = dataSource {
                orderNumLabel.text = "订单编号： \(detail.orderId)"
                createTimeLabel.text = "下单时间： \(stringDateByTimestamp(timeStamp: detail.createAt/1000))"
                payWayLabel.text = "支付方式： \(detail.payType == 0 ? "支付宝" : "微信")"
                orderAmoutLabel.text = "订单金额： ¥\(detail.cashFee)"
            }
        }
    }
    
    private func setUpUI(){
        selectionStyle = .none
        contentView.addSubview(orderNumLabel)
        contentView.addSubview(createTimeLabel)
        contentView.addSubview(payWayLabel)
        contentView.addSubview(orderAmoutLabel)
        
        orderNumLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.height.equalTo(18)
        }
        createTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.top.equalTo(orderNumLabel.snp.bottom).offset(10)
            make.height.equalTo(18)
        }
        payWayLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.top.equalTo(createTimeLabel.snp.bottom).offset(10)
            make.height.equalTo(18)
        }
        orderAmoutLabel.snp.makeConstraints { (make) in
            make.top.equalTo(payWayLabel.snp.bottom).offset(10)
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.height.equalTo(18)
        }
        
    }

    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
        setUpUI();
    }
    
    override init(style:UITableViewCellStyle, reuseIdentifier:String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI();
    }
    
    private lazy var orderNumLabel: UILabel = {
        let label = UILabel()
        label.textColor = XFConstants.Color.darkGray
        label.font = XFConstants.Font.pfn12
        label.textAlignment = .left
        return label
    }()
    
    private lazy var createTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = XFConstants.Color.darkGray
        label.font = XFConstants.Font.pfn12
        label.textAlignment = .left
        return label
    }()
    
    private lazy var payWayLabel: UILabel = {
        let label = UILabel()
        label.textColor = XFConstants.Color.darkGray
        label.font = XFConstants.Font.pfn12
        label.textAlignment = .left
        return label
    }()
    
    private lazy var orderAmoutLabel: UILabel = {
        let label = UILabel()
        label.textColor = XFConstants.Color.darkGray
        label.font = XFConstants.Font.pfn12
        label.textAlignment = .left
        return label
    }()

    
}
