//
//  XFCommonService.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import Foundation
import Alamofire
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
        self.doPost(withUrl: url("/auth/register"), params: params, encoding: JSONEncoding.default){ (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(XFUser.deserialize(from: dict) ?? XFUser())
            }
        }
    }
    
    func login( params:XFParams,  _ completion:@escaping XFResponse) {
        self.doPost(withUrl: url("/auth/login"), params: params){ (success, respData) in
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
    
    func getProductDetail(pid:Int, _ completion:@escaping XFResponse) {
        self.doGet(withUrl: url("/product/detail?prodId=\(pid)")) { (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(ProductDetail.deserialize(from: dict) ?? ProductDetail())
            }
        }
    }
    
    
    func addAddress(params:XFParams, _ completion:@escaping XFResponse) {
        print(params)
       // http://api.10fruits.net/address/add?code=110101&&address=成寿寺2&recipient=王小码&cellPhone=13269528888&isDefault=1&label=家2
        
        let code:String  = params["code"] as! String
        let address:String = params["address"] as! String
        let recipient:String = params["recipient"] as! String
        let cellPhone:String = params["cellPhone"] as! String
        let isDefault:String = params["isDefault"] as! String
        let label:String  = params["label"] as! String
        
//        let url_combile = url("/address/add?code=\(code)&address=\(address)&recipient=\(recipient)&cellPhone=\(cellPhone)&isDefault=\(isDefault)&label=\(label)")
        
        // 注意Post请求不需要拼接&参数，其实url函数你用法错了，看看定义！！！
        self.doPost(withUrl: url("/address/add"), params: params) { (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(ProductDetail.deserialize(from: dict) ?? ProductDetail())
            }
        }
    }
    
    
    
}

