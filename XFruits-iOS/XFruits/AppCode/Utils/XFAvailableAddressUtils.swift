//
//  XFUserGlobal.swift
//  XFruits
//
//  Created by tangkunyin on 02/07/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import Foundation
import HandyJSON

class XFAvailableAddressUtils {
    
    /// 当前登录用户
    var addressDict:XFAvailableAddressDict?
    
    static let shared = XFAvailableAddressUtils()
    private init(){
        let cachedAddr:XFAvailableAddressDict? = getCachedAddress()
        if let addr = cachedAddr {
            addressDict = addr
        }
    }

    
    /// 用户信息缓存文件地址
    private lazy var availableAddressPath:String? = {
        let path:String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return "\(path)/XFAvailableAddressDict.info"
    }()
    
    
    
    /// 归档用户模型到本地缓存
    func cacheAddress(_ addess:XFAvailableAddressDict) {
        let userInfo:NSDictionary = addess.toJSON()! as NSDictionary
        if let filePath = availableAddressPath {
            let success:Bool = NSKeyedArchiver.archiveRootObject(userInfo, toFile: filePath)
            dPrint("地址缓存：\(success ? "成功" : "失败")")
        }
    }
    
    
    /// 从缓存中取得地址
    ///
    /// - Returns: 缓存中的地址
    func getCachedAddress() -> XFAvailableAddressDict? {
        if let filePath = availableAddressPath {
            let userInfo = NSKeyedUnarchiver.unarchiveObject(withFile: filePath)
            if userInfo is NSDictionary, let info:NSDictionary = userInfo as? NSDictionary {
                let address = XFAvailableAddressDict.deserialize(from: info)
                return address
            }
        }
        return nil
    }
    
    
    /// 清楚缓存地址信息
    private func clearCachedUser() {
        do {
            let fileManager = FileManager.default
            if let filePath = availableAddressPath {
                if fileManager.fileExists(atPath: filePath) {
                    try fileManager.removeItem(atPath: filePath)
                }
            }
        } catch let error as NSError {
            dPrint("用户缓存信息删除失败: \(error.localizedDescription)")
        }
    }
    
    func cacheAddressAvailable()  {
        // 把地址的json文件下载下来
        DispatchQueue.global().async {
            let cachedData: XFAvailableAddressDict? = XFAvailableAddressUtils.shared.getCachedAddress()
            // 没找到就去服务器拉
            if  cachedData == nil {
                XFCommonService().allAvailableAddress(page: 1, size: 4000 ) { (data) in
                    if let addresses = data  as? XFAvailableAddressDict{
                        XFAvailableAddressUtils.shared.cacheAddress(addresses)
                    }
                }
            }
        }
    }
    
}
