//
//  AppDelegate.swift
//  XFruits
//
//  Created by tangkunyin on 2017/4/9.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    fileprivate func initExternalSDK(){
        V5ClientAgent.initWithSiteId(XFConstants.SDK.V5KF.siteId,
                                     appId: XFConstants.SDK.V5KF.appId) { (status, desc) in
            dPrint("[V5 Init result] status:\(status) desc:\(desc ?? "desc none")")
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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame:UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        
        window?.rootViewController = XFHomeViewController()
        
        window?.makeKeyAndVisible()
        
        initExternalSDK()
        creatShortcutItem()
        
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

