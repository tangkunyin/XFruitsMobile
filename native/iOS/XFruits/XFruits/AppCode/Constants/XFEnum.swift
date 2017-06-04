//
//  XFEnum.swift
//  XFruits
//
//  Created by tangkunyin on 2017/4/22.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import Foundation


// 网络状态
public enum XFNetStateCode {
    case reachable       //有网络
    case notReachable    //无网络
}


// HTTP返回码
public enum XFHttpStatusCode:Int {
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
