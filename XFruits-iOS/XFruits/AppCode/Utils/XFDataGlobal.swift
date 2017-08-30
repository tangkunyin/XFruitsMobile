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
    fileprivate init(){}
    
    /// 服务器时间，默认客户端当前系统时间
    lazy var serverTime: Int = {
        return localTimestamp()
    }()
    
    
    /// 是否是第一次进入app，如果是，本地缓存标记
    ///
    /// - Returns: Bool
    func isTheFirstOpenApp() -> Bool {
        let userDefauls: UserDefaults = UserDefaults.standard
        if userDefauls.string(forKey: "isTheFirstOpenXFruitsApp") != nil {
            return false
        }
        userDefauls.set("false", forKey: "isTheFirstOpenXFruitsApp")
        userDefauls.synchronize()
        return true
    }
    
    
}
