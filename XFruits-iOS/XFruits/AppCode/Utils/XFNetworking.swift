//
//  XFNetworking.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import HandyJSON
import Alamofire
import SwiftyJSON
import MBProgressHUD


public typealias XFResponse = ((_ data: Any)->Void)

public typealias XFParams = Dictionary<String,Any>

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
public enum XFHttpStatus: Int {
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

public struct ApiServer {
    /// 服务器连接超时时间
    static let timeout:Double = 45.0
    
    /// API服务器正式地址
    static let test:String = "https://test.10fruits.net"
    
    /// API服务器正式地址
    static let onLine:String = "https://www.10fruits.net"
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


public class XFNetworking: NSObject {
    
//    let manager: Alamofire.SessionManager = {
//        let serverTrustPolicies: [String: ServerTrustPolicy] = [
//            "10fruits.net": .disableEvaluation
//        ]
//        let configuration = URLSessionConfiguration.default
//        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
//
//        return Alamofire.SessionManager(
//            configuration: configuration,
//            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
//        )
//    }()
    
    public func url(_ uri:String, params:XFParams? = nil) -> String {
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
    
    public func doGet(withUrl url:String,
                      encoding:ParameterEncoding = URLEncoding.default,
                      completion:@escaping XFNetCompletion) {
        self.doRequest(withUrl: url, method: .get, params: nil, paramsEncoding: encoding, completion: completion)
    }
    
    public func doPost(withUrl url:String,
                       params:Dictionary<String,Any>,
                       encoding:ParameterEncoding = URLEncoding.default,
                       completion:@escaping XFNetCompletion) {
        self.doRequest(withUrl: url, method: .post, params: params, paramsEncoding: encoding, completion: completion)
    }
    
    
    public func commonRequest(withUrl url:String,
                              params:Dictionary<String,Any>? = nil,
                              method:Alamofire.HTTPMethod = .get,
                              encoding:ParameterEncoding = URLEncoding.default,
                              completion:@escaping XFNetCompletion) {
        self.doRequest(withUrl: url,
                       method: method,
                       params: params,
                       paramsEncoding: encoding,
                       needSerialize: false,
                       completion: completion)
    }
    
    public func doRequest(withUrl url:String,
                          method:Alamofire.HTTPMethod,
                          params:Dictionary<String,Any>?,
                          paramsEncoding:ParameterEncoding,
                          needSerialize:Bool = true,
                          completion:@escaping XFNetCompletion) {
        
        guard XFNetworkStatus.shareInstance.canReachable() else {
            MBProgressHUD.showError("网络不可用，请检查先~")
            completion(false, nil)
            return
        }
        
        var headers: HTTPHeaders?
        if var token = XFUserGlobal.shared.token {
            token = token.trimmingCharacters(in: .whitespacesAndNewlines)
            headers = ["Authorization": "Bearer \(token)"]
        }
        
        Alamofire.request(url, method: method, parameters: params, encoding: paramsEncoding,headers: headers)
            .validate().responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    if needSerialize {
                        if let obj:XFBaseResponse = XFBaseResponse.deserialize(from: json.rawString()) {
                            guard let code = obj.code, let msg = obj.msg, let timestamp = obj.systemTime else {
                                dPrint(obj)
                                completion(false, "数据状态异常，请稍后再试~")
                                return
                            }
                            //更新服务器时间
                            XFDataGlobal.shared.serverTime = timestamp
                            switch code {
                            case XFHttpStatus.success.rawValue,
                                 XFHttpStatus.notModify.rawValue,
                                 XFHttpStatus.returnTrue.rawValue:
                                completion(true, obj.data)
                            default:
                                MBProgressHUD.showError(msg)
                                completion(false, msg)
                            }
                        }
                    } else {
                        completion(true, json)
                    }
                case .failure(let error):
                    dPrint(error)
                    completion(false, error)
                }
        }
    }
    
    
}

