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
    
    func url(_ uri:String) -> String {
        return ApiServer.onLine + uri
    }

    func getVerifyImage(_ completion:@escaping XFruitsResponse) {
        self.doGet(withUrl: url("/auth/captcha")) { (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(VerifyImage.deserialize(from: dict) ?? VerifyImage())
            }
        }
    }
    
    
    
    
    
    
    
}
