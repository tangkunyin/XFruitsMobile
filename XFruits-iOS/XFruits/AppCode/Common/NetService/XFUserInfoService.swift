//
//  XFProductService.swift
//  XFruits
//
//  Created by tangkunyin on 2017/9/10.
//  Copyright © 2017年 zhaojian. All rights reserved.
//

import Foundation
import Alamofire
import HandyJSON
import SwiftyJSON

final class XFUseInfoService: XFNetworking {
    
    class func getUserInfo(_ completion:@escaping XFResponse) {
        doGet(withUrl: url("/user/profile")) { (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(XFUser.deserialize(from: dict) ?? XFUser())
            }
        }
    }
    
    
    class func  updateUserInfo(params: Dictionary<String, Any>,_ completion:@escaping XFResponse) {
       // print(params)
        doPost(withUrl: url("/user/profile"), params: params, encoding: JSONEncoding.default){ (success, respData) in
            print(respData! )
            if success {
                completion(respData as! NSNumber)
            }
        }
    }
}
