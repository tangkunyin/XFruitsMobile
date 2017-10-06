//
//  XFProductService.swift
//  XFruits
//
//  Created by tangkunyin on 2017/9/10.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import Foundation
import Alamofire
import HandyJSON
import SwiftyJSON

final class XFProductService: XFNetworking {

    class func getAllCategoryies(_ completion:@escaping XFResponse) {
        doGet(withUrl: url("/product/type")) { (success, respData) in
            if success, respData is Array<Any>, let list = respData as? Array<Any> {
                completion([ProductType].deserialize(from: JSON(list).rawString()) ?? [])
            }
        }
    }
    
    class func getAllProducts(params:XFParams, completion:@escaping XFResponse) {
        doGet(withUrl: url("/product/list", params: params)) { (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(CategoryList.deserialize(from: dict) ?? CategoryList())
            } else {
                completion(false)
            }
        }
    }
    
    class func getProductDetail(pid:String, _ completion:@escaping XFResponse) {
        doGet(withUrl: url("/product/detail?prodId=\(pid)")) { (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(ProductDetail.deserialize(from: dict) ?? ProductDetail())
            }
        }
    }
}
