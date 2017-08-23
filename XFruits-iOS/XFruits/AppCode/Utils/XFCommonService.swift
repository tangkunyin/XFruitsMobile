//
//  XFCommonService.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import Foundation
import Alamofire
import HandyJSON
import SwiftyJSON


/// 具体业务请求
final class XFCommonService: XFNetworking {

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
            } else {
                completion(false)
            }
        }
    }

    func getProductDetail(pid:String, _ completion:@escaping XFResponse) {
        self.doGet(withUrl: url("/product/detail?prodId=\(pid)")) { (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(ProductDetail.deserialize(from: dict) ?? ProductDetail())
            }
        }
    }



}
