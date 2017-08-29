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
        
        window?.rootViewController = slideRootVC
        
        window?.makeKeyAndVisible()
        
        return handleShortCutAction(withOptions: launchOptions)
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
    
    private func handleShortCutAction(withOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) ->Bool {
        if let options = launchOptions {
            let item = (options as NSDictionary).value(forKey: UIApplicationLaunchOptionsKey.shortcutItem.rawValue)
            if item != nil, item is UIApplicationShortcutItem {
                let shortCutItem = item as! UIApplicationShortcutItem
                switch shortCutItem.type {
                case XFConstants.ShortCut.Order:
                    navigateTo(controller: XFOrderListViewController(), loginCheck: true)
                    break
                case XFConstants.ShortCut.Express:
                    navigateTo(controller: XFAboutCompanyViewController(), loginCheck: true)
                    break
                case XFConstants.ShortCut.Personal:
                    navigateTo(controller: XFWebViewController(withUrl: "https://www.10fruits.cn/customization/personal.html"),
                               loginCheck: false)
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
    
    private func navigateTo(controller: UIViewController, loginCheck:Bool) {
        if loginCheck && !XFUserGlobal.shared.isLogin {
            let realController = UINavigationController.init(rootViewController: XFUserLoginViewController())
            window?.rootViewController?.present(realController, animated: false, completion: nil)
        } else {
            let realController = XFNavigationController.init(rootViewController: controller)
            window?.rootViewController?.navigationController?.pushViewController(realController, animated: false)
        }
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
        XFCommonService().getAllCategoryies { (types) in
            if let productTypes = types as? Array<ProductType> {
                weakSelf?.allCateListVC.dataSource = productTypes
            }
        }
    }
    
    fileprivate func creatShortcutItem(){
        let icon1:UIApplicationShortcutIcon = UIApplicationShortcutIcon(templateImageName: "Express_3D_Icon")
        let icon2:UIApplicationShortcutIcon = UIApplicationShortcutIcon(templateImageName: "OrderList_3D_Icon")
//        let icon3:UIApplicationShortcutIcon = UIApplicationShortcutIcon(templateImageName: "PersonalOrdering_3D_Icon")
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
//        let personalOrdering:UIApplicationShortcutItem = UIApplicationShortcutItem(type: XFConstants.ShortCut.Personal,
//                                                                                   localizedTitle: "私人定制",
//                                                                                   localizedSubtitle: nil,
//                                                                                   icon: icon3,
//                                                                                   userInfo: nil)
        let aboutXFruits:UIApplicationShortcutItem = UIApplicationShortcutItem(type: XFConstants.ShortCut.AboutUs,
                                                                                   localizedTitle: "关于我们",
                                                                                   localizedSubtitle: nil,
                                                                                   icon: icon4,
                                                                                   userInfo: nil)
        UIApplication.shared.shortcutItems = [express, orderList, /*personalOrdering,*/ aboutXFruits]
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
    
    
}
