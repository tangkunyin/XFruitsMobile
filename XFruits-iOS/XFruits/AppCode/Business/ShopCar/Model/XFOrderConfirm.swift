//
//  XFOrderConfirm.swift
//  XFruits
//
//  Created by tangkunyin on 2017/7/30.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import HandyJSON

/// 确认订单模型
class XFOrderConfirm: HandyJSON {
    var address: XFAddress?
    var couponList: Array<XFCouponItem>?
    required init() {}
}


/// 订单提交返回模型
class XFPayChannel: HandyJSON {
    var name: String?
    var channel: Int?
    var defaultChannel: Bool?
    required init() {}
}
class XFOrderCommit: HandyJSON {
    var cashFee: String?
    var orderId: String?
    var orderExpiration: Int?
    var payChannels: Array<XFPayChannel?> = []
    required init() {}
}
