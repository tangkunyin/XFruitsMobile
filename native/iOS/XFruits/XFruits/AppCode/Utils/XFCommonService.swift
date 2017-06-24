//
//  XFCommonService.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import Foundation
import MBProgressHUD
import HandyJSON
import SwiftyJSON

public typealias XFResponse = ((_ data: Any)->Void)

public typealias XFParams = Dictionary<String,Any>


struct ApiServer {
    /// 服务器连接超时时间
    static let timeout:Double = 45.0
    
    /// API服务器正式地址
    static let test:String = "http://test.10fruits.net"
    
    /// API服务器正式地址
    static let onLine:String = "http://api.10fruits.net"
}


/// 具体业务请求
public final class XFCommonService: XFNetworking {
    
    func url(_ uri:String, params:XFParams? = nil) -> String {
        if let params = params, !params.isEmpty {
            var url:String = ApiServer.onLine + uri + "?"
            for (index, obj) in params.enumerated() {
                if index == 0 {
                    url.append("\(obj.key)=\(obj.value)")
                } else {
                    url.append("&\(obj.key)=\(obj.value)")
                }
            }
            return url
        } else {
            return ApiServer.onLine + uri
        }
    }
    
    func getVerifyImage(_ completion:@escaping XFResponse) {
        self.doGet(withUrl: url("/auth/captcha")) { (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(XFVerifyImage.deserialize(from: dict) ?? XFVerifyImage())
                
            }
        }
    }
    
    func vertifyImageCodeAndSendMessageCode( params:XFParams,  _ completion:@escaping XFResponse) {
        self.doPost(withUrl: url("/auth/captcha"), params: params){ (success, respData) in
            if success  {
                completion(respData as! Bool)
            }
        }
    }
    func register( params:XFParams,  _ completion:@escaping XFResponse) {
        self.doPost(withUrl: url("/auth/register"), params: params){ (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(XFUser.deserialize(from: dict) ?? XFUser())
            }
        }
    }
    
    func getAllCategoryies(_ completion:@escaping XFResponse) {
        self.doGet(withUrl: url("/product/type")) { (success, respData) in
            if success, respData is Array<Any>, let list = respData as? Array<Any> {
                completion([ProductType].deserialize(from: JSON(list).rawString()) ?? [])
            }
        }
    }
    
    func getAllProducts(params:XFParams, completion:@escaping XFResponse) {
        self.doGet(withUrl: url("/product/list", params: params)) { (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(CategoryList.deserialize(from: dict) ?? CategoryList())
            }
        }
    }
    
    func getProductDetail(_ completion:@escaping XFResponse) {
        
        
    }
    
    
    
    
}

