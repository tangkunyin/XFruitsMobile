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

    func getProductDetail(pid:String, _ completion:@escaping XFResponse) {
        self.doGet(withUrl: url("/product/detail?prodId=\(pid)")) { (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(ProductDetail.deserialize(from: dict) ?? ProductDetail())
            }
        }
    }


    func getUserAllAddress(_ completion:@escaping XFResponse) {
        self.doGet(withUrl: url("/user/address")) { (success, respData) in
            if success, respData is Array<Any>, let list = respData as? Array<Any> {
                completion([XFAddress].deserialize(from: JSON(list).rawString()) ?? [])
            }
        }
    }



    func addAddress(params:XFParams, _ completion:@escaping XFResponse) {

        self.doPost(withUrl: url("/address/add"), params: params) { (success, respData) in
            if success  {
                completion(respData as! Bool)
            }
        }
    }


    func deleteAddress(addressId:Int, params:XFParams,_ completion:@escaping XFResponse) {

        self.doPost(withUrl: url("/address/remove?id=\(addressId)"),params: params) { (success, respData) in
            if success  {
                completion(respData as! Bool)
            }
        }
    }
//    http://api.10fruits.net/address/modify?id=1002&&code=110101&&address=成寿寺3&recipient=x小码&cellPhone=13269528889&isDefault=0&label=家3
    func modifyAddress( params:XFParams, _ completion:@escaping XFResponse) {
       
        self.doPost(withUrl: url("/address/modify"),params: params) { (success, respData) in

          if success  {
              completion(respData as! Bool)
          }
        }
    }


    // 请求三级联动的地址   http://api.10fruits.net/address/district?page=1&&size=4000
    
    func allAvailableAddress(page:Int,size:Int ,  _ completion:@escaping XFResponse) {
        self.doGet(withUrl: url("/address/district?page=\(page)&size=\(size)")) { (success, respData) in
            
//            if success, respData is NSDictionary, let list:NSArray = respData["content"] {
//                 completion([XFAvailableAddress].deserialize(from: JSON(list).rawString()) ?? [])
//            }
            if success, respData is NSDictionary, let dict = respData as? NSDictionary{
               completion(XFAvailableAddressDict.deserialize(from: dict) ?? XFAvailableAddressDict())
            }
        }

    }


    /// 确认订单
    ///
    /// - Parameter completion: XFOrderConfirm
    func orderConfirm(_ completion:@escaping XFResponse) {
        self.doGet(withUrl: url("/order/confirm")) { (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(XFOrderConfirm.deserialize(from: dict) ?? XFOrderConfirm())
            }
        }
    }

}
