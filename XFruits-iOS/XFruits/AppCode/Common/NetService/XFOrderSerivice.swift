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
    
}
