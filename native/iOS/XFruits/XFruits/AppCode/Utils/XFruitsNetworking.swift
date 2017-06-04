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

// 网络状态
public enum XFNetStateCode {
    case unKnown
    case reachable      //有网络
    case notReachable   //无网络
    case wwan           //无网络
    case wifi           //无网络
}


// HTTP返回码
public enum XFHttpStatusCode:Int,HandyJSONEnum {
    //通用状态码
    case success = 200           //请求成功
    case notModify = 304         //资源未修改
    case unAuthoriztion = 401    //请求未授权
    case forbidden = 403         //禁止访问
    case notFound = 404          //资源不存在
    case reqMethodError = 405    //请求方法错误。例如要求用POST请求，用了GET
    case serverError = 500       //服务器内部错误
    
    //自定义状态码(可根据接口实际情况更改)
    case dataParseError = -1     //数据解析错误
    case returnNull = 0          //服务返回为空
    case returnFalse = 1000      //请求失败(可能是未知原因)
    case returnTrue = 1001       //请求成功
    case missingArgs = 1002      //请求缺少参数，或参数不符合要求
    case verifyError = 1003      //验证码错误
    case missingSign = 1004      //缺少签名或签名字段错误
    case signError = 1005        //签名错误
    case uploadError = 1006      //上传文件失败
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
                      completion:@escaping (_ success: Bool, _ respData: Any)->Void) {
        self.doRequest(withUrl: url, method: .get, params: nil, respObj: respObj, headers: nil, completion: completion)
    }
    
    public func doPost(withUrl url:String,
                       respObj:AnyClass?,
                       params:Dictionary<String,Any>,
                       completion:@escaping (_ success: Bool, _ respData: Any)->Void) {
        self.doRequest(withUrl: url, method: .post, params: nil, respObj: respObj, headers: nil, completion: completion)
    }
    
    public func doRequest(withUrl url:String,
                          method:Alamofire.HTTPMethod,
                          params:Dictionary<String,Any>?,
                          respObj:AnyClass?,
                          headers:Dictionary<String,String>?,
                          completion:@escaping (_ success: Bool, _ respData: Any?)->Void) {
        
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
                                    case .success:
                                        dPrint(obj.data)
                                    case .forbidden:
                                        dPrint("禁止访问")
                                    default:
                                        dPrint("未知")
                                    }
                                    
                                    
                                }
                            case .failure(let error):
                                dPrint(error)
                                completion(false, error)
                            }
        }
    }
    

}
