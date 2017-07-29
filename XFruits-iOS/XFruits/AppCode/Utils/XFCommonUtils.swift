
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
func currentTimestamp() ->Int {
    let now = Date()
    let timeInterval:TimeInterval = now.timeIntervalSince1970
    let timeStamp = Int(timeInterval)
    return timeStamp
}


func isPhoneNumber(phoneNumber:String) -> Bool {
    if phoneNumber.characters.count == 0 {
        return false
    }
    let mobile = "^(13[0-9]|15[0-9]|18[0-9]|17[0-9]|147)\\d{8}$"
    let regexMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
    if regexMobile.evaluate(with: phoneNumber) == true {
        return true
    }else
    {
        return false
    }
}

func stringDateByTimestamp(timeStamp:Int, formatter:String? = "yyyy-MM-dd HH:mm:ss") -> String {
    let dformatter = DateFormatter()
    dformatter.dateFormat = formatter
    
    let timeInterval:TimeInterval = TimeInterval(timeStamp)
    let date = Date(timeIntervalSince1970: timeInterval)
    
    let stringDate = dformatter.string(from: date)
    return stringDate
}


/// 创建通用客服聊天室
///
/// - Parameters:
///   - user: 用户信息
///   - goodsInfo: 商品信息（当浏览商品时可传入，便于客服了解用户咨询的产品）
/// - Returns: 聊天室
func createChatViewController(withUser user:XFUser?, goodsInfo:ProductDetail?) -> V5ChatViewController {
    
    let config = V5ClientAgent.shareClient().config
    /// 配置用户信息和商品信息
    if let config = config {
        if let user = user {
            config.nickname = user.username
            config.gender = user.sex ?? 0
            config.avatar = user.avatar
            config.vip = user.vip ?? 0
            config.openId = user.token
        } else {
            config.nickname = "iOS端未登录的匿名用户"
            config.gender = 0
            //未登录的匿名用户使用时间戳作为唯一标示符
            config.openId = "iOS_RandomUser_\(currentTimestamp())"
        }
        if let goodsInfo = goodsInfo {
            config.userInfo = JSON(goodsInfo).dictionaryValue
        }
    }
    
    let v5chatVC = V5ClientAgent.createChatViewController()

    // 允许并设置消息铃声SystemSoundID
    v5chatVC.allowSound = true;
    v5chatVC.soundID = 1007;
    // 允许发送语音
    v5chatVC.enableVoiceRecord = true;
    // 允许显示头像
    v5chatVC.showAvatar = true;
    // 头像圆角(0~20之间)
    v5chatVC.avatarRadius = 6;
    // 每次下拉获取历史消息最大数量，默认10
    v5chatVC.numOfMessagesOnRefresh = 10;
    // 开场显示历史消息数量，默认0(显示历史消息>0则无开场白)
    v5chatVC.numOfMessagesOnOpen = 10;
    // 设置会话界面标题
    v5chatVC.title = "小果拾"
    
    // 设置开场白方式,启动会话前设置，默认ClientOpenModeDefault
    // ClientOpenModeQuestion结合后台机器人培训内容可根据使用场景配置不同需求的开场消息
    v5chatVC.setClientOpenMode(.ClientOpenModeQuestion, withParam: nil)
    // 设置聊天背景色
    v5chatVC.chatTableView.backgroundColor = XFConstants.Color.commonBackground
    return v5chatVC
}

