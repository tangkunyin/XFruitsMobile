//
//  XFDataGlobal.swift
//  XFruits
//
//  Created by tangkunyin on 2017/7/28.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import Foundation


/// 全局内存数据库
class XFDataGlobal {

    static let shared = XFDataGlobal()
    private init(){}
    
    /// 服务器时间，默认客户端当前系统时间
    lazy var serverTime: Int = {
        return localTimestamp()
    }()
    
    
}
