//
//  AppDelegate.swift
//  XFruits
//
//  Created by tangkunyin on 2017/4/9.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    lazy var request:XFCommonService = {
        let serviceRequest = XFCommonService()
        return serviceRequest
    }()
    
    lazy var allCateListVC: XFAllCategoryListViewController = {
        return XFAllCategoryListViewController()
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        creatShortcutItem()
        fetchAdditionData()
        initExternalSDK()
        
        window = UIWindow(frame:UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        
        let rootVC = XFHomeViewController()
        
        SlideMenuOptions.rightViewWidth = 168
        SlideMenuOptions.contentViewOpacity = 0.75
        SlideMenuOptions.tapGesturesEnabled = true
        SlideMenuOptions.panGesturesEnabled = false
        let slideRootVC = SlideMenuController(mainViewController: rootVC,
                                              rightMenuViewController:allCateListVC)
        slideRootVC.automaticallyAdjustsScrollViewInsets = true
        slideRootVC.delegate = rootVC.categoryVC as? SlideMenuControllerDelegate
        
        window?.rootViewController = slideRootVC
        window?.makeKeyAndVisible()
        
        if let options = launchOptions {
            let item = (options as NSDictionary).value(forKey: UIApplicationLaunchOptionsKey.shortcutItem.rawValue)
            
            let test:UIViewController = XFAllCategoryListViewController()
            
            if item != nil, item is UIApplicationShortcutItem {
                let shortCutItem = item as! UIApplicationShortcutItem
                switch shortCutItem.type {
                case XFConstants.ShortCut.Express:
                    window?.rootViewController?.present(test, animated: true, completion: nil)
                    break
                case XFConstants.ShortCut.Contact:
                    window?.rootViewController?.present(test, animated: true, completion: nil)
                    break
                case XFConstants.ShortCut.Share:
                    window?.rootViewController?.present(test, animated: true, completion: nil)
                    break
                default:break
                }
            }
            return false
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        //退出到后台时，通知 SDK 用户离线
        V5ClientAgent.shareClient().onApplicationDidEnterBackground()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        //移动到前台时，通知 SDK 用户上线并连接
        V5ClientAgent.shareClient().onApplicationWillEnterForeground()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
        
    }
    
}

extension AppDelegate: WXApiDelegate {
    
    func initExternalSDK(){
        
        /// 初始化客服SDK
        V5ClientAgent.initWithSiteId(XFConstants.SDK.V5KF.siteId,
                                     appId: XFConstants.SDK.V5KF.appId) { (status, desc) in
            dPrint("[V5 Init result] status:\(status) desc:\(desc ?? "desc none")")
        }
        
        // 注册微信
        WXApi.registerApp(XFConstants.SDK.Wechat.appId)
    }
    
    /// 拉取全局唯一数据
    func fetchAdditionData() {
        weak var weakSelf = self
        
        // 拉取所有分类数据
        request.getAllCategoryies { (types) in
            if let productTypes = types as? Array<ProductType> {
                weakSelf?.allCateListVC.dataSource = productTypes
            }
        }
    }
    
    fileprivate func creatShortcutItem(){
        let expressIcon:UIApplicationShortcutIcon = UIApplicationShortcutIcon(templateImageName: "express-shortIcon")
        let express:UIApplicationShortcutItem = UIApplicationShortcutItem(type: XFConstants.ShortCut.Express,
                                                                          localizedTitle: "最新物流",
                                                                          localizedSubtitle: nil,
                                                                          icon: expressIcon,
                                                                          userInfo: nil)
        
        let contactIcon:UIApplicationShortcutIcon = UIApplicationShortcutIcon(templateImageName: "contact-short-icon")
        let contact:UIApplicationShortcutItem = UIApplicationShortcutItem.init(type: XFConstants.ShortCut.Contact,
                                                                               localizedTitle: "联系客服",
                                                                               localizedSubtitle: nil,
                                                                               icon: contactIcon,
                                                                               userInfo: nil)
        
        let shareIcon:UIApplicationShortcutIcon = UIApplicationShortcutIcon(templateImageName: "share-shortIcon")
        let share:UIApplicationShortcutItem = UIApplicationShortcutItem(type: XFConstants.ShortCut.Share,
                                                                        localizedTitle: "鲜果分享",
                                                                        localizedSubtitle: nil,
                                                                        icon: shareIcon,
                                                                        userInfo: nil)
        UIApplication.shared.shortcutItems = [express, contact, share]
    }
    
    
    /// - Returns: 处理第三方应用跳转
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if let scheme = url.scheme, scheme == XFConstants.SDK.Wechat.appId {
            return WXApi.handleOpen(url, delegate: self)
        }
        if let host = url.host, host == "safepay" {
            // 支付宝跳转支付宝钱包进行支付，处理支付结果
            AlipaySDK.defaultService().processOrder(withPaymentResult: url, standbyCallback: { (result) in
                if let result = result {
                    dPrint(result)
                }
            })
            // 授权跳转支付宝进行支付，处理支付结果
            AlipaySDK.defaultService().processAuth_V2Result(url, standbyCallback: { (result) in
                if result != nil, let dict = result as NSDictionary? {
                    var authCode: String = ""
                    let resultString:String = dict.value(forKey: "result") as! String
                    if resultString.characters.count > 0 {
                        let resultArr: Array<String> = resultString.components(separatedBy: "&")
                        for subResult in resultArr {
                            if subResult.characters.count > 10 && subResult.hasPrefix("auth_code=") {
                                let index = subResult.index(subResult.startIndex, offsetBy: 10)
                                authCode = subResult.substring(from: index)
                                break
                            }
                        }
                    }
                    dPrint("支付宝授权结果：\(authCode)")
                }
            })
        }
        return true
    }
    
    
}
