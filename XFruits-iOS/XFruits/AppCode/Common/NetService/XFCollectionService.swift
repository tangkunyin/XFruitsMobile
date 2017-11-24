//
//  XFAddressService.swift
//  XFruits
//
//  Created by tangkunyin on 2017/8/19.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import Foundation
import Alamofire
import HandyJSON
import SwiftyJSON

final class XFCollectionService: XFNetworking {
    
    /// 获取收藏列表
    class func getCollectionList(params: Dictionary<String, Any>, _ completion:@escaping XFResponse) {
        doGet(withUrl: url("/collection/my", params: params)) { (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(XFCollection.deserialize(from: dict) ?? XFCollection())
            }
        }
    }
    
    
 
    
    // 添加收藏
    class func addCollection(params:Dictionary<String, String>, _ completion:@escaping XFResponse) {
        print(params)
        doPost(withUrl: url("/collection/add"), params: params){ (success, respData) in
            if success , let success = respData as? Bool {
                completion(success)
            }
        }
    }
    
    
    // 删除收藏
    class func deleteCollection(params:Dictionary<String, String>,_ completion:@escaping XFResponse) {
        doPost(withUrl: url("/collection/delete"), params: params){ (success, respData) in
            if success   {
                completion(success)
            }
        }
    }
    
   
    
}
