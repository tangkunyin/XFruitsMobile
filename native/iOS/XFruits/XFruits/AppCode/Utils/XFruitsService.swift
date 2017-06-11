//
//  XFruitsService.swift
//  XFruits
//
//  Created by tangkunyin on 11/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import Foundation
import MBProgressHUD
import HandyJSON

public typealias XFruitsResponse = ((_ data: Any)->Void)

public typealias XFruitsParams = Dictionary<String,Any>


struct ApiServer {
    /// 服务器连接超时时间
    static let timeout:Double = 45.0
    
    /// API服务器正式地址
    static let test:String = "http://test.10fruits.net"
    
    /// API服务器正式地址
    static let onLine:String = "http://api.10fruits.net"
}


/// 具体业务请求
public final class XFruitsService: XFruitsNetworking {
    
    func url(_ uri:String, params:XFruitsParams? = nil) -> String {
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

    func getVerifyImage(_ completion:@escaping XFruitsResponse) {
        self.doGet(withUrl: url("/auth/captcha")) { (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(VerifyImage.deserialize(from: dict) ?? VerifyImage())
            }
        }
    }
    
    func getAllCategoryies(_ completion:@escaping XFruitsResponse) {
        self.doGet(withUrl: url("/product/type")) { (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(ProductType.deserialize(from: dict) ?? ProductType())
            }
        }
    }
    
    func getAllProducts(params:XFruitsParams, completion:@escaping XFruitsResponse) {
        self.doGet(withUrl: url("/product/list", params: params)) { (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(ProductItem.deserialize(from: dict) ?? ProductItem())
            }
        }
    }
    
    func getProductDetail(_ completion:@escaping XFruitsResponse) {
        
        
    }
    
    
    
    
}
