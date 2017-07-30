//
//  XFCouponItem.swift
//  XFruits
//
//  Created by tangkunyin on 2017/7/30.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import HandyJSON


/// 优惠券项目
struct XFCouponItem: HandyJSON {
    var id:String?
    // 券类别 1001-直减券 1002-打折券 1003-免邮券
    var coupon:String?
    // 额度
    var number:Float?
    // 使用条件，满多少可用
    var condition:Float?
    // 0-已使用 1-未使用 2-已失效
    var status:Int?
}
