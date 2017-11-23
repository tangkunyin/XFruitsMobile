//
//  AppDelegate.swift
//  XFruits
//
//  Created by tangkunyin on 2017/4/9.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import UserNotifications
import MBProgressHUD


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        creatShortcutItem()
        fetchAdditionData()
        initExternalSDK()
        
        window = UIWindow(frame:UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        
        window?.rootViewController = XFHomeViewController()
        
        window?.makeKeyAndVisible()
        
        return handleShortCutAction(withOptions: launchOptions)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        QYSDK.shared().logout {
            dPrint("客服退出成功")
        }
    }
    
    fileprivate func handleShortCutAction(withOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) ->Bool {
        if let options = launchOptions {
            let item = (options as NSDictionary).value(forKey: UIApplicationLaunchOptionsKey.shortcutItem.rawValue)
            if item != nil, item is UIApplicationShortcutItem {
                let shortCutItem = item as! UIApplicationShortcutItem
                switch shortCutItem.type {
                case XFConstants.ShortCut.Order:
                    navigateTo(controller: XFOrderListViewController(), loginCheck: true)
                    break
                case XFConstants.ShortCut.Express:
                    navigateTo(controller: XFOrderListViewController(), loginCheck: true)
                    break
                case XFConstants.ShortCut.Personal:
                    navigateTo(controller: XFSettingsViewController(), loginCheck: false)
                    break
                case XFConstants.ShortCut.AboutUs:
                    window?.rootViewController?.present(XFAppGuideViewController(), animated: true, completion: nil)
                default:
                    break
                }
            }
        }
        return true
    }
    
    fileprivate func navigateTo(controller: UIViewController, loginCheck:Bool) {
        if loginCheck && !XFUserGlobal.shared.isLogin {
            let realController = UINavigationController.init(rootViewController: XFUserLoginViewController())
            window?.rootViewController?.navigationController?.pushViewController(realController, animated: false)
        } else {
            let realController = XFNavigationController.init(rootViewController: controller)
            window?.rootViewController?.navigationController?.pushViewController(realController, animated: false)
        }
    }
    
}

extension AppDelegate: WXApiDelegate, UNUserNotificationCenterDelegate {

    fileprivate func registerForRemoteNotification() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.sound, .alert, .badge], completionHandler: { (granted, error) in
                if error == nil {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            })
        } else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    func initExternalSDK() {
        // 注册网易七鱼客服
        QYSDK.shared().registerAppId(XFConstants.SDK.QYKF.appKey, appName: XFConstants.SDK.QYKF.appName)
        
        // 注册推送服务
        registerForRemoteNotification()
        
        // 注册微信
        WXApi.registerApp(XFConstants.SDK.Wechat.appId)
    }
    
    /// 拉取全局唯一数据
    func fetchAdditionData() {
        // 拉取地址数据
        XFAvailableAddressUtils.shared.cacheAddressAvailable()
        
    }
    
    fileprivate func creatShortcutItem(){
        let icon1:UIApplicationShortcutIcon = UIApplicationShortcutIcon(templateImageName: "Express_3D_Icon")
        let icon2:UIApplicationShortcutIcon = UIApplicationShortcutIcon(templateImageName: "OrderList_3D_Icon")
        let icon3:UIApplicationShortcutIcon = UIApplicationShortcutIcon(templateImageName: "PersonalOrdering_3D_Icon")
        let icon4:UIApplicationShortcutIcon = UIApplicationShortcutIcon(templateImageName: "AboutUS_3D_icon")
        let express:UIApplicationShortcutItem = UIApplicationShortcutItem(type: XFConstants.ShortCut.Express,
                                                                          localizedTitle: "最新物流",
                                                                          localizedSubtitle: nil,
                                                                          icon: icon1,
                                                                          userInfo: nil)
        let orderList:UIApplicationShortcutItem = UIApplicationShortcutItem(type: XFConstants.ShortCut.Order,
                                                                            localizedTitle: "我的订单",
                                                                            localizedSubtitle: nil,
                                                                            icon: icon2,
                                                                            userInfo: nil)
        let personalOrdering:UIApplicationShortcutItem = UIApplicationShortcutItem(type: XFConstants.ShortCut.Personal,
                                                                                   localizedTitle: "私人定制",
                                                                                   localizedSubtitle: nil,
                                                                                   icon: icon3,
                                                                                   userInfo: nil)
        let aboutXFruits:UIApplicationShortcutItem = UIApplicationShortcutItem(type: XFConstants.ShortCut.AboutUs,
                                                                                   localizedTitle: "关于我们",
                                                                                   localizedSubtitle: nil,
                                                                                   icon: icon4,
                                                                                   userInfo: nil)
        UIApplication.shared.shortcutItems = [express, orderList, personalOrdering, aboutXFruits]
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
                    if resultString.count > 0 {
                        let resultArr: Array<String> = resultString.components(separatedBy: "&")
                        for subResult in resultArr {
                            if subResult.count > 10 && subResult.hasPrefix("auth_code=") {
                                let index = subResult.index(subResult.startIndex, offsetBy: 10)
                                authCode = "\(subResult[..<index])"
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
    
    func onResp(_ resp: BaseResp!) {
        if resp.isKind(of: PayResp.self) {
            var resp1 = PayResp.init()
            resp1 = resp as! PayResp
            dPrint(resp1.returnKey)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "wxpay"), object: NSNumber.init(value: resp.errCode))
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        QYSDK.shared().updateApnsToken(deviceToken)
    }
    
    //Called when a notification is delivered to a foreground app.
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        MBProgressHUD.showMessage(notification.request.content.userInfo.description, completion: nil)
        completionHandler([.alert, .badge, .sound])
    }
    
    //Called to let your app know which action was selected by the user for a given notification.
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        MBProgressHUD.showMessage(response.notification.request.content.userInfo.description, completion: nil)
        completionHandler()
    }
}
