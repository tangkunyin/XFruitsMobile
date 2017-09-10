
//
//  XFAuthService.swift
//  XFruits
//
//  Created by tangkunyin on 2017/9/10.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import Foundation
import Alamofire
import HandyJSON
import SwiftyJSON

final class XFAuthService: XFNetworking {

    class func getVerifyImage(_ completion:@escaping XFResponse) {
        doGet(withUrl: url("/auth/captcha")) { (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(XFVerifyImage.deserialize(from: dict) ?? XFVerifyImage())
                
            }
        }
    }
    
    class func vertifyImageCodeAndSendMessageCode( params:XFParams,  _ completion:@escaping XFResponse) {
        doPost(withUrl: url("/auth/captcha"), params: params){ (success, respData) in
            if success  {
                completion(respData ?? false)
            }
        }
    }
    
    class func register( params:XFParams,  _ completion:@escaping XFResponse) {
        doPost(withUrl: url("/auth/register"), params: params, encoding: JSONEncoding.default){ (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(XFUser.deserialize(from: dict) ?? XFUser())
            }
        }
    }
    
    class func login( params:XFParams,  _ completion:@escaping XFResponse) {
        doPost(withUrl: url("/auth/login"), params: params){ (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(XFUser.deserialize(from: dict) ?? XFUser())
            }
        }
    }
    
    class func resetPassword( params:XFParams,  _ completion:@escaping XFResponse) {
        doPost(withUrl: url("/auth/password"), params: params, encoding: JSONEncoding.default){ (success, respData) in
            completion(success)
        }
    }
}
