//
//  XFOrderConfirm.swift
//  XFruits
//
//  Created by tangkunyin on 2017/7/30.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import HandyJSON

/// 确认订单模型
struct XFOrderConfirm: HandyJSON {
    var address: XFAddress?
    var couponList: Array<XFCouponItem>?
}
