//
//  XFUserGlobal.swift
//  XFruits
//
//  Created by tangkunyin on 02/07/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import Foundation
import HandyJSON

struct XFUserGlobal {

    static let shared = XFUserGlobal()
    private init(){}
    
    
    /// 记录登录状态，是否登录
    var isLogin:Bool = false
    
    /// 当前登录用户
    var currentUser:XFUser?
    
    
    /// 当前用户token，只读
    var token:String? {
        get {
            if let user = currentUser {
                return user.token
            }
            return nil
        }
    }
    
    
    /// 用户信息缓存文件地址
    private lazy var userCacheFilePath:String? = {
        let path:String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return "\(path)/XFruits_currentUser.info"
    }()
    
    
    /// 登录
    mutating func signIn(user:XFUser) {
        if let token:String = user.token, token.characters.count > 0 {
            isLogin = true
            currentUser = user
            cacheUser(user)
        }
    }
    
    
    /// 退出
    mutating func signOff() {
        isLogin = false
        currentUser = nil
        clearCachedUser()
    }
    
    
    /// 归档用户模型到本地缓存
    private mutating func cacheUser(_ user:XFUser) {
        let userInfo:NSDictionary = user.toJSON()! as NSDictionary
        if let filePath = userCacheFilePath {
            let success:Bool = NSKeyedArchiver.archiveRootObject(userInfo, toFile: filePath)
            dPrint("用户信息缓存：\(success ? "成功" : "失败")")
        }
    }
    
    
    /// 从缓存中取得用户
    ///
    /// - Returns: 缓存中的用户
    private mutating func getCachedUser() -> XFUser? {
        if let filePath = userCacheFilePath {
            let userInfo = NSKeyedUnarchiver.unarchiveObject(withFile: filePath)
            if userInfo is NSDictionary, let info:NSDictionary = userInfo as? NSDictionary {
                let user = XFUser.deserialize(from: info)
                return user
            }
        }
        return nil
    }
    
    
    /// 清楚用户缓存信息
    private mutating func clearCachedUser() {
        do {
            let fileManager = FileManager.default
            if let filePath = userCacheFilePath {
                if fileManager.fileExists(atPath: filePath) {
                    try fileManager.removeItem(atPath: filePath)
                }
            }
        } catch let error as NSError {
            dPrint("用户缓存信息删除失败: \(error.localizedDescription)")
        }
    }
    
}
