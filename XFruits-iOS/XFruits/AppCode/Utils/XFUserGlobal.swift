//
//  XFUserGlobal.swift
//  XFruits
//
//  Created by tangkunyin on 02/07/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import Foundation
import HandyJSON

class XFUserGlobal {

    static let shared = XFUserGlobal()
    fileprivate init(){
        let cachedUser:XFUser? = getCachedUser()
        if let user = cachedUser {
            isLogin = true
            currentUser = user
        }
    }
    
    
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
    
    
    /// 账户事件类型。0注册，1找回密码
    var accountActionType:Int = 0
    
    
    /// 用户信息缓存文件地址
    fileprivate lazy var userCacheFilePath:String? = {
        let path:String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return "\(path)/XFruits_currentUser.info"
    }()
    
    
    /// 登录
    func signIn(user:XFUser) {
        if let token:String = user.token, token.characters.count > 0 {
            isLogin = true
            currentUser = user
            cacheUser(user)
        }
    }
    
    
    /// 退出
    func signOff() {
        isLogin = false
        currentUser = nil
        clearCachedUser()
    }
    
    
    /// 归档用户模型到本地缓存
    fileprivate func cacheUser(_ user:XFUser) {
        let userInfo:NSDictionary = user.toJSON()! as NSDictionary
        if let filePath = userCacheFilePath {
            let success:Bool = NSKeyedArchiver.archiveRootObject(userInfo, toFile: filePath)
            dPrint("用户信息缓存：\(success ? "成功" : "失败")")
        }
    }
    
    
    /// 从缓存中取得用户
    ///
    /// - Returns: 缓存中的用户
    fileprivate func getCachedUser() -> XFUser? {
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
    fileprivate func clearCachedUser() {
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
