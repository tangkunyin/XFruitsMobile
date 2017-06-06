//
//  XFruitsNetworking.swift
//  XFruits
//
//  Created by tangkunyin on 04/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import AlamofireSwiftyJSON
import SwiftyJSON
import HandyJSON


public typealias XFNetCompletion = ((_ success: Bool, _ respData: Any?)->Void)


// 网络状态
public enum XFNetStateCode {
    case unKnown        //未知网络
    case reachable      //有网络
    case notReachable   //无网络
    case wwan           //无网络
    case wifi           //无网络
}


// HTTP返回码
public enum XFHttpStatus:Int, HandyJSONEnum {
    //通用状态码
    case success = 200
    case notModify = 304
    case unAuthoriztion = 401
    case forbidden = 403
    case notFound = 404
    case reqMethodError = 405
    case serverError = 500
    //自定义状态码(可根据接口实际情况更改)
    case dataParseError = -1
    case returnNull = 0
    case returnFalse = 1000
    case returnTrue = 1001
    case missingArgs = 1002
    case verifyError = 1003
    case missingSign = 1004
    case signError = 1005
    case uploadError = 1006
    var description: String {
        switch self {
        case .success:
            return "请求成功"
        case .notModify:
            return "资源未更改"
        case .unAuthoriztion:
            return "请求未授权"
        case .forbidden:
            return "禁止访问"
        case .notFound:
            return "资源不存在"
        case .reqMethodError:
            return "请求方法错误"
        case .serverError:
            return "服务器内部错误"
        case .dataParseError:
            return "数据解析错误"
        case .returnNull:
            return "服务器返回空"
        case .returnFalse:
            return "操作失败，返回false"
        case .returnTrue:
            return "操作成功，返回true"
        case .missingArgs:
            return "参数丢失或不符合接口规范"
        case .verifyError:
            return "验证码错误"
        case .missingSign:
            return "签名丢失"
        case .signError:
            return "签名错误"
        case .uploadError:
            return "上传错误"
        }
    }
}


/// 网络状态监听
public final class XFNetworkStatus: NSObject {
    
    public static let shareInstance: XFNetworkStatus = XFNetworkStatus()
    
    public var listener:((_ status:XFNetStateCode) -> Void)? = nil
    
    public var currentStatus: XFNetStateCode = .unKnown
    
    private var reachability:NetworkReachabilityManager = NetworkReachabilityManager(host: "www.qq.com")!

    private override init() {
        super.init()
        weak var weakSelf = self
        reachability.listener = { status in
            switch status {
            case .notReachable:
                weakSelf!.currentStatus = .notReachable
            case .unknown:
                weakSelf!.currentStatus = .unKnown
            case .reachable(let type):
                switch type {
                case .ethernetOrWiFi:
                    weakSelf!.currentStatus = .wifi
                case .wwan:
                    weakSelf!.currentStatus = .wwan
                }
            }
            if weakSelf!.listener != nil {
                weakSelf!.listener!(weakSelf!.currentStatus)
            }
        }
        reachability.startListening()
    }
    
    public func canReachable() -> Bool {
        return self.reachability.isReachable
    }
}


public class XFruitsNetworking: NSObject {

    public func doGet(withUrl url:String,
                      respObj:AnyClass?,
                      completion:@escaping XFNetCompletion) {
        self.doRequest(withUrl: url, method: .get, params: nil, respObj: respObj, headers: nil, completion: completion)
    }
    
    public func doPost(withUrl url:String,
                       respObj:AnyClass?,
                       params:Dictionary<String,Any>,
                       completion:@escaping XFNetCompletion) {
        self.doRequest(withUrl: url, method: .post, params: nil, respObj: respObj, headers: nil, completion: completion)
    }
    
    public func doRequest(withUrl url:String,
                          method:Alamofire.HTTPMethod,
                          params:Dictionary<String,Any>?,
                          respObj:AnyClass?,
                          headers:Dictionary<String,String>?,
                          completion:@escaping XFNetCompletion) {
        
        guard XFNetworkStatus.shareInstance.canReachable() else {
            MBProgressHUD.showError("网络不可用，请检查先~")
            completion(false, nil)
            return
        }
        
        Alamofire.request(url, method: method, parameters: params, encoding: URLEncoding.default,
                          headers: headers).responseSwiftyJSON { (dataResponse) in
                            switch dataResponse.result {
                            case .success(let value):
                                if let obj:XFBaseResponse = XFBaseResponse.deserialize(from: value.rawString()) {
                                    switch obj.code {
                                    case .success,.notModify,.returnTrue:
                                        completion(true,obj.data)
                                    default:
                                        MBProgressHUD.showError(obj.code.description)
                                        completion(false,nil)
                                    }
                                }
                            case .failure(let error):
                                dPrint(error)
                                completion(false, error)
                            }
        }
    }
    

}
