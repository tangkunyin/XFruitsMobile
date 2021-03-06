//
//  XFOrderSerivice.swift
//  XFruits
//
//  Created by tangkunyin on 2017/8/16.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import Foundation
import Alamofire
import HandyJSON
import SwiftyJSON

final class XFOrderSerivice: XFNetworking {

    /// 确认订单
    class func orderConfirm(_ completion:@escaping XFResponse) {
        doGet(withUrl: url("/order/confirm")) { (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(XFOrderConfirm.deserialize(from: dict) ?? XFOrderConfirm())
            }
        }
    }
    
    /// 提交订单
    class func orderCommit(params: Dictionary<String, Any>, _ completion:@escaping XFResponse) {
        doPost(withUrl: url("/order/commit"), params: params, encoding: JSONEncoding.default){ (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(XFOrderCommit.deserialize(from: dict) ?? XFOrderCommit())
            }
        }
    }
    
    class func orderPayCommit(params: Dictionary<String, Any>, _ completion:@escaping XFResponse) {
        doPost(withUrl: url("/order/payChannel"), params: params){ (success, respData) in
            if success, respData is String, let respData = respData as? String {
                completion(respData)
            }
        }
    }
    
    /// 获取订单列表
    class func getOrderList(params: Dictionary<String, Any>, _ completion:@escaping XFResponse) {
        doGet(withUrl: url("/order/query", params: params)) { (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(XFOrder.deserialize(from: dict) ?? XFOrder())
            }
        }
    }
    
    /// 获取订单详情
    class func getOrderDetail(params: Dictionary<String, Any>, _ completion:@escaping XFResponse) {
        doGet(withUrl: url("/order/detail", params: params)) { (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(XFOrderDetail.deserialize(from: dict) ?? XFOrderDetail())
            }
        }
    }
    
    /// 获取物流信息
    class func getExpressDetail(params: Dictionary<String, Any>, _ completion:@escaping XFResponse) {
        doGet(withUrl: url("/express/trackInfo", params: params)) { (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(XFExpress.deserialize(from: dict) ?? XFExpress())
            }
        }
    }
    
    /// 确认收货
    class func confirmOrder(params: Dictionary<String, Any>, _ completion:@escaping XFResponse) {
        doPost(withUrl: url("/order/confirmOrder"), params: params){ (success, respData) in
            if success {
                completion(respData as Any)
            }
        }
    }
    
    /// 商品评价
    class func orderComment(params: Dictionary<String, Any>, _ completion:@escaping XFResponse) {
        doPost(withUrl: url("/comment/add"), params: params){ (success, respData) in
            if success {
                completion(respData as Any)
            }
        }
    }
}
