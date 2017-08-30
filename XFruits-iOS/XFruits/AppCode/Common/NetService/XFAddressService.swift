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

class XFAddressService: XFNetworking {

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
    
    
    func modifyAddress( params:XFParams, _ completion:@escaping XFResponse) {
        self.doPost(withUrl: url("/address/modify"),params: params) { (success, respData) in
            if success  {
                completion(respData as! Bool)
            }
        }
    }
    
    func getDistrictData(_ completion:@escaping XFResponse) {
        self.commonRequest(withUrl: url("/address/district")) { (success, respData) in
            if success, let respData = respData {
                completion(respData)
            }
        }
    }
    
}
