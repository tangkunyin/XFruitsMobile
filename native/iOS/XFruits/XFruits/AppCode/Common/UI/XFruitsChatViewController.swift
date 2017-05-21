//
//  XFruitsChatViewController.swift
//  XFruits
//
//  Created by tangkunyin on 21/05/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import SwiftyJSON

class XFruitsChatViewController: V5ChatViewController,V5ChatViewDelegate {

    convenience init(withUser user:XFruitsUser?, goodsInfo:XFruitsGoodsInfo?){
        self.init()
        let config = V5ClientAgent.shareClient().config
        /// 配置用户信息和商品信息
        if let config = config {
            if let user = user {
                config.nickname = user.nickName
                config.gender = user.gender ?? 0
                config.avatar = user.avatar
                config.vip = user.vip ?? 0
                config.openId = user.userId
            } else {
                config.nickname = "未登录匿名用户"
                config.gender = 0
                config.avatar = ""
                config.vip = -1
                //未登录的匿名用户使用时间戳作为唯一标示符
                config.openId = "\(currentTimestamp())"
            }
            if let goodsInfo = goodsInfo {
                config.userInfo = JSON(goodsInfo).dictionaryValue
            }
            //用于推送消息
            config.deviceToken = ""
            //更新用户信息或者切换用户时需调用shouldUpdateUserInfo
            config.shouldUpdateUserInfo()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if V5ClientAgent.shareClient().isConnected {
            V5ClientAgent.shareClient().stopClient()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor.white
        
        let v5chatVC = V5ClientAgent.createChatViewController()
        v5chatVC.delegate = self
        v5chatVC.hidesBottomBarWhenPushed = true
        
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
        v5chatVC.setClientOpenMode(.ClientOpenModeDefault, withParam: nil)
        
        self.view.addSubview(v5chatVC.view)
    }
    
    // MARK: - 客户端连接成功
    func onClientViewConnect() {
        print("客户端连接成功")
    }
    
    //MARK: - 会话即将关闭
    func clientViewDidDisappear() {
        print("客户即将离开聊天")
    }
    
    //MARK: - 用户将要发送消息
    func userWillSend(_ message: V5Message) -> V5Message {
        
        // 此处可进行拦截，将客户的会话记录到我方数据库
        
        return message
    }
    
    // MARK: - 用户在会话中收到消息
    func clientDidReceive(_ message: V5Message) {
        // 我们的客服说了啥
        
    }
    
    // MARK: - 客户服务状态改变(可在此相应改变对话页标题)
    func clientViewController(_ chatVC: V5ChatViewController, servingStatusChange status: KV5ClientServingStatus) {
        switch status {
        case .ServingStatus_queue,.ServingStatus_robot:
            chatVC.title = "正在排队等人工，云客服服务中"
        case .ServingStatus_worker:
            chatVC.title = "\(V5ClientAgent.shareClient().config?.workerName ?? "小果拾")为您服务"
        case .ServingStatus_inTrust:
            chatVC.title = "云客服服务中"
        }
    }
    
}
