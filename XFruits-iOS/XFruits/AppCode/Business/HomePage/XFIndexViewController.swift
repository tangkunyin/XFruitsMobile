//
//  XFIndexViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD


class XFIndexViewController: XFBaseViewController,V5ChatViewDelegate {
    
    lazy var pagerView:XFViewPager = {
        let imageUrls = ["http://bizhi.zhuoku.com/2011/07/20/Benbenmiao/Benbenmiao130.jpg",
                         "http://img3.iqilu.com/data/attachment/forum/201308/22/161503hoakfzi7fqkk7711.jpg",
                         "http://www.33lc.com/article/UploadPic/2012-8/20128179522243094.jpg"]
        let pagerView = XFViewPager(source: imageUrls, placeHolder: nil)
            pagerView.pagerDidClicked = {(index:Int) -> Void in
                dPrint("\(index) 号被点击")
                MBProgressHUD.showError("链接没有准备好呢，小果拾表示骚瑞~")
            }
        return pagerView
    }()
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if V5ClientAgent.shareClient().isConnected {
            V5ClientAgent.shareClient().stopClient()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.imageWithNamed("scan-icon"),
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(onScanItemClick))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.imageWithNamed("msg-icon"),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(onMessageItemClick))
        
        self.view.addSubview(pagerView)
        pagerView.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view).offset(0)
            make.width.equalTo(self.view)
            // TODO: 提前约定好宽高比
            make.height.equalTo(floor(XFConstants.UI.deviceWidth/(1920/1080)))
            
        })
        
    }
    
    @objc private func onScanItemClick(){
        
        MBProgressHUD.showMessage("小果拾表示这个功能还没想好怎么做...") {
            dPrint("扫描：小果拾表示这个功能还没想好怎么做...")
        }
        
    }
    
    @objc private func onMessageItemClick(){
        let chatVC = createChatViewController(withUser: nil, goodsInfo: nil)
        chatVC.delegate = self
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
    
    // MARK: - 客户端连接成功
    func onClientViewConnect() {
        dPrint("客户端连接成功")
    }
    
    //MARK: - 会话即将关闭
    func clientViewDidDisappear() {
        dPrint("客户即将离开聊天")
    }
    
    //MARK: - 用户将要发送消息
    func userWillSend(_ message: V5Message) -> V5Message {
        
        // 此处可进行拦截，将客户的会话记录到我方数据库
        dPrint("用户说：\(message.getDefaultContent())")
        
        return message
    }
    
    // MARK: - 用户在会话中收到消息
    func clientDidReceive(_ message: V5Message) {
        // 我们的客服说了啥
        dPrint("客服说：\(message.getDefaultContent())")
    }
    
    // MARK: - 客户服务状态改变(可在此相应改变对话页标题)
    func clientViewController(_ chatVC: V5ChatViewController, servingStatusChange status: KV5ClientServingStatus) {
        switch status {
        case .ServingStatus_queue,.ServingStatus_robot:
            chatVC.title = "正在排队等人工..."
        case .ServingStatus_worker:
            chatVC.title = "\(V5ClientAgent.shareClient().config?.workerName ?? "小果拾")为您服务"
        case .ServingStatus_inTrust:
            chatVC.title = "云客服服务中"
        }
    }
    
    
    
}

