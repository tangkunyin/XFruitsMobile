//
//  XFUserGlobal.swift
//  XFruits
//
//  Created by tangkunyin on 02/07/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import Foundation
import HandyJSON
import Alamofire
import SwiftyJSON
class XFAvailableAddressUtils {
    
    /// 当前登录用户
    var addressDict:NSDictionary?
    
    static let shared = XFAvailableAddressUtils()
    fileprivate init(){
//        let cachedAddr:NSDictionary? = getCachedAddress()
        
    }

    
    /// 用户信息缓存文件地址
    fileprivate lazy var availableAddressPath:String? = {
        var path:String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        path = "\(path)/XFAddress.info"
        return path
    }()
    

    
    /// 归档用户模型到本地缓存
    func cacheAddress(_ addess:NSDictionary) {
       
        if let filePath = availableAddressPath {
            let success:Bool = NSKeyedArchiver.archiveRootObject(addess, toFile: filePath)
            dPrint("地址缓存：\(success ? "成功" : "失败")")
        }
    }
    
    
    /// 从缓存中取得地址
    ///
    /// - Returns: 缓存中的地址
    func getCachedAddress() -> NSDictionary? {
        let path:String = availableAddressPath!
        if(FileManager.default.fileExists(atPath: path)){
            let addressInfo:NSDictionary  =   NSKeyedUnarchiver.unarchiveObject(withFile: path) as! NSDictionary
            return addressInfo
        }
        return nil
    }
    
    
    /// 清楚缓存地址信息
    fileprivate func clearCachedUser() {
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
    
    func cacheAddressAvailable() {
        weak var weakSelf = self
        XFAddressService().getDistrictData { (result) in
            let responseJSON: NSDictionary = result as! NSDictionary
            let newMd5:String = responseJSON["md5"] as! String
            let path:String = (weakSelf?.availableAddressPath)!
            if(FileManager.default.fileExists(atPath: path)){
                let addressInfo:NSDictionary  = (weakSelf?.getCachedAddress())!
                let cacheMd5:String = addressInfo["md5"] as! String
                // 判断 md5是否一致，如果一致就不存新的数据
                if (cacheMd5 != newMd5){  // 不一致
                    weakSelf?.cacheAddress(responseJSON)
                }
            } else{
                FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
                weakSelf?.cacheAddress(responseJSON)
            }
        }
    }
    
}
