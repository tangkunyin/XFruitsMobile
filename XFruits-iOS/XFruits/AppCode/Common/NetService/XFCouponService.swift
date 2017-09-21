//
//  XFCouponService.swift
//  XFruits
//
//  Created by tangkunyin on 2017/9/20.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import Foundation
import Alamofire
import HandyJSON
import SwiftyJSON

final class XFCouponService: XFNetworking {

    /// 获取优惠券列表
    class func getCouponList(_ completion:@escaping XFResponse) {
        doGet(withUrl: url("/coupon/list")) { (success, respData) in
            if success, respData is Array<Any>, let list = respData as? Array<Any> {
                completion([XFCouponItem].deserialize(from: JSON(list).rawString()) ?? [])
            }
        }
    }
    
    /// 兑换优惠券
    class func bindCoupon(params: Dictionary<String, Any>, _ completion:@escaping XFResponse) {
        doPost(withUrl: url("/coupon/bind"), params: params){ (success, respData) in
            if success {
                completion(true)
            } else {
                completion(respData ?? "骚瑞啊，优惠券兑换失败 :) ")
            }
        }
    }
    
}
