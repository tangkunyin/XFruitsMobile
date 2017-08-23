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
    func orderConfirm(_ completion:@escaping XFResponse) {
        self.doGet(withUrl: url("/order/confirm")) { (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(XFOrderConfirm.deserialize(from: dict) ?? XFOrderConfirm())
            }
        }
    }
    
    /// 提交订单
    func orderCommit(params: Dictionary<String, Any>, _ completion:@escaping XFResponse) {
        self.doPost(withUrl: url("/order/commit"), params: params, encoding: JSONEncoding.default){ (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(XFOrderCommit.deserialize(from: dict) ?? XFOrderCommit())
            }
        }
    }
    
    func orderPayCommit(params: Dictionary<String, Any>, _ completion:@escaping XFResponse) {
        self.doPost(withUrl: url("/order/payChannel"), params: params){ (success, respData) in
            if success, respData is String, let dict = respData as? String {
                completion(dict);
            }
        }
    }
    
    /// 获取订单列表
    func getOrderList(params: Dictionary<String, Any>, _ completion:@escaping XFResponse) {
        self.doGet(withUrl: url("/order/query", params: params)) { (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(XFOrder.deserialize(from: dict) ?? XFOrder())
            }
        }
    }
    
    /// 获取订单详情
    func getOrderDetail(params: Dictionary<String, Any>, _ completion:@escaping XFResponse) {
        self.doGet(withUrl: url("/order/detail", params: params)) { (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(XFOrderDetail.deserialize(from: dict) ?? XFOrderDetail())
            }
        }
    }
    
    /// 获取物流信息
    func getExpressDetail(params: Dictionary<String, Any>, _ completion:@escaping XFResponse) {
        self.doGet(withUrl: url("/express/trackInfo", params: params)) { (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(XFExpress.deserialize(from: dict) ?? XFExpress())
            }
        }
    }
    
    /// 确认收货
    func confirmOrder(params: Dictionary<String, Any>, _ completion:@escaping XFResponse) {
        self.doPost(withUrl: url("/order/confirmOrder"), params: params){ (success, respData) in
            if success {
                completion(respData as Any)
            }
        }
    }
}
