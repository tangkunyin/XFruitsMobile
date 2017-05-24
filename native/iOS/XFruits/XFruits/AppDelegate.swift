//
//  AppDelegate.swift
//  XFruits
//
//  Created by tangkunyin on 2017/4/9.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import V5ClientAgent

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    fileprivate func initExternalSDK(){
        V5ClientAgent .initWithSiteId(XFConstants.SDK.V5KF.siteId,
                                      appId: XFConstants.SDK.V5KF.appId) { (status, desc) in
            print("[V5 Init result] status:\(status) desc:\(desc ?? "desc none")")
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        window = UIWindow(frame:UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        
        window?.rootViewController = XFruitsHomeViewController()
        
        window?.makeKeyAndVisible()
        
        
        initExternalSDK()
        
        
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

