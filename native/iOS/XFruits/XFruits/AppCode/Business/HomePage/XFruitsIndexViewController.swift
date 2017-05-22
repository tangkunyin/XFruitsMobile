//
//  XFruitsIndexViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/4/9.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD

class XFruitsIndexViewController: XFruitsBaseViewController,V5ChatViewDelegate {
    
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
        
    
        let imageUrls = ["http://desk.fd.zol-img.com.cn/g5/M00/02/0B/ChMkJ1bK1fSIOoJHAAFWaDrqe94AALJsANLr7kAAVaA928.jpg",
                         "http://b.zol-img.com.cn/desk/bizhi/image/2/960x600/1359447948761.jpg",
                         "http://www.xs-a.com/userfiles/2016510271041230.08.jpg",
                         "http://i2.download.fd.pchome.net/t_960x600/g1/M00/08/1D/ooYBAFOnwieIezFzAAKCDjZ0CaoAABoWgCQspUAAoIm250.jpg"];
        
        
        let pagerView = XFruitsViewPager(source: imageUrls, placeHolder: nil)
        pagerView.pagerDidClicked = {(index:Int) -> Void in
            print("\(index) 号被点击")
            MBProgressHUD.showError("点个毛线啊，链接都没有")
        }
        
        
        self.view.addSubview(pagerView)

        pagerView.snp.makeConstraints({ (make) in
            make.top.equalTo(0)
            make.height.equalTo(204)
            make.centerX.equalTo(self.view)
        })
        
        // 跳转到登录页面
//        let loginVC  = XFruitsUserLoginViewController()
//        let nav = UINavigationController(rootViewController:loginVC)
//
//        self.present(nav, animated: true, completion: nil)

        
    }
    
    @objc private func onScanItemClick(){
        
        MBProgressHUD.showMessage("扫描毛线啊...") {
            print("扫描毛线啊")
        }
    }
    
    @objc private func onMessageItemClick(){
        let chatVC = createChatViewController(withUser: nil, goodsInfo: nil)
        chatVC.delegate = self
        navigationController?.pushViewController(chatVC, animated: true)
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
        print("用户说：\(message.getDefaultContent())")
        
        return message
    }
    
    // MARK: - 用户在会话中收到消息
    func clientDidReceive(_ message: V5Message) {
        // 我们的客服说了啥
        print("客服说：\(message.getDefaultContent())")
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
