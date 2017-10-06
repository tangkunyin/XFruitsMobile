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
    
    var id:Int?
    
    var couponCode:String?
    
    // 1001”直减券”、1002”折扣券”、1003”邮费券”
    var couponType:Int = 0
    
    // 额度
    var valueFee:Float = 0
    
    // 使用条件，满多少可用
    var conditionFee:Float = 0
    
    // 0-已使用 1-未使用 2-已失效
    var status:Int = 2
    
    // 生效时间
    var validateAt:Int = 0
    
    // 过期时间
    var expireAt:Int = 0
    
}
