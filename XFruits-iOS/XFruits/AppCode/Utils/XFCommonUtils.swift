
//
//  XFCommonUtils.swift
//  XFruits
//
//  Created by tangkunyin on 21/05/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import SwiftyJSON


/// 调试日志输出，正式版会自动屏蔽Log打印
func dPrint(_ item: Any) {
    #if DEBUG
    debugPrint(item)
    #endif
}

/// 当前时间的时间戳
func localTimestamp() ->Int {
    let now = Date()
    let timeInterval:TimeInterval = now.timeIntervalSince1970
    let timeStamp = Int(timeInterval)
    return timeStamp
}

/// 获取系统版本号
func getLocalVersion() -> String {
    var localVersion:String = "1.0.0"
    if let v:String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String{
        localVersion = v
    }
    return localVersion
}


func isPhoneNumber(phoneNumber: String?) -> Bool {
    if let phoneNumber = phoneNumber {
        if phoneNumber.count == 0 {
            return false
        }
        let mobile = "^(13[0-9]|15[0-9]|18[0-9]|17[0-9]|147)\\d{8}$"
        let regexMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        if regexMobile.evaluate(with: phoneNumber) == true {
            return true
        } else {
            return false
        }
    }
    return false
}

func stringDateByTimestamp(timeStamp:Int, formatter:String? = "yyyy-MM-dd HH:mm:ss") -> String {
    let dformatter = DateFormatter()
    dformatter.dateFormat = formatter
    
    let timeInterval:TimeInterval = TimeInterval(timeStamp)
    let date = Date(timeIntervalSince1970: timeInterval)
    
    let stringDate = dformatter.string(from: date)
    return stringDate
}

//: 拨打电话给客服
func makePhoneCall(tel: String = "01057266082")  {
    UIApplication.shared.openURL(URL(string: "tel://\(tel)")!)
}

//: 创建会话界面
func createChatViewController(title: String, product: ProductDetail? = nil) -> UIViewController? {
    
    // 清空消息未读数
    QYSDK.shared().conversationManager().clearUnreadCount()
    
    // 定义通用界面
    QYSDK.shared().customUIConfig().rightBarButtonItemColorBlackOrWhite = false
    QYSDK.shared().customUIConfig().showImageEntry = true
    QYSDK.shared().customUIConfig().showEmoticonEntry = true
    
    let sessionController = QYSDK.shared().sessionViewController()
    sessionController?.sessionTitle = "很高兴为您笑劳"
    
    let source = QYSource()
    source.title = title
    
    // 如果用户登录
    if XFUserGlobal.shared.isLogin,
        let user: XFUser = XFUserGlobal.shared.currentUser {
        source.customInfo = user.toJSONString()
    } else {
        source.customInfo = "未登录的吃瓜观众"
    }
    
    // 如果有商品信息
    if let product = product {
        let commodityInfo = QYCommodityInfo()
        commodityInfo.title = product.name
        commodityInfo.desc = product.specification
        commodityInfo.pictureUrlString = product.cover[0]
        commodityInfo.urlString = product.description[0]
        commodityInfo.note = "价格：\(product.primePrice)"
        commodityInfo.show = true
        sessionController?.commodityInfo = commodityInfo
    }
    
    sessionController?.source = source
    sessionController?.hidesBottomBarWhenPushed = true
    sessionController?.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    return sessionController
}
