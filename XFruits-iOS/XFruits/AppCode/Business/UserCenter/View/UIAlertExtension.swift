//
//  UIAlertExtension.swift
//  ActionDemo
//
//  Created by zhangfan on 17/6/15.
//  Copyright © 2017年 Qlink. All rights reserved.
//
import Foundation
import UIKit

var kTag = "kTag"

// MARK : - UIAlertAction
extension UIAlertAction {
    var tag: NSInteger? {
        get {
            return objc_getAssociatedObject(self, &kTag) as! NSInteger?
        }
        set(newValue) {
            objc_setAssociatedObject(self, &kTag, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

// MARK : - UIAlertController
extension UIAlertController {
    public typealias DismissBlock = (_ btnIndex: NSInteger) -> Swift.Void
    public typealias CancelBlock = () -> Swift.Void
    
    /*
     弹出提示框+关闭按钮（默认叫关闭）
     */
    public class func alert(title: String?, message: String?) {
        let titleStr = title != nil ? title : ""
        let messageStr = message != nil ? message : ""
        
        let alertVC = UIAlertController(title: titleStr, message: messageStr, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "关闭", style: .cancel, handler: nil))
        self.topViewController()?.present(alertVC, animated: true, completion: nil)
    }
    
    /*
     弹出提示框+关闭按钮（自定义关闭按钮文字）
     */
    public class func alert(title: String?, message: String?, cancelButtonTitle: String?) {
        let titleStr = title != nil ? title : ""
        let messageStr = message != nil ? message : ""
        let cancelButtonTitleStr = cancelButtonTitle != nil ? cancelButtonTitle : ""
        
        let alertVC = UIAlertController(title: titleStr, message: messageStr, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: cancelButtonTitleStr, style: .cancel, handler: nil))
        self.topViewController()?.present(alertVC, animated: true, completion: nil)
    }
    
    /*
     弹出提示框+自定义各种文字
     */
    
    public class func alert(title: String?, message: String?, cancelButtonTitle: String?, otherButtons: NSArray?, dismiss: DismissBlock? = nil, cancel: CancelBlock? = nil) {
        let titleStr = title != nil ? title : ""
        let messageStr = message != nil ? message : ""
        let cancelButtonTitleStr = cancelButtonTitle != nil ? cancelButtonTitle : ""
        
        // 提示控制器
        let alertVC = UIAlertController(title: titleStr, message: messageStr, preferredStyle: .alert)
        // 添加控制器上的按钮
        alertVC.addAction(UIAlertAction(title: cancelButtonTitleStr, style: .cancel, handler: { (UIAlertAction) in
            if cancel != nil {
                cancel!()
            }
            
        }))
        
        if otherButtons?.count != 0 && otherButtons != nil {
            // 按钮不止一个
            for index in 1...otherButtons!.count {
                let btnTitle = String(describing: otherButtons![index - 1])
                let actionItem = UIAlertAction(title: btnTitle, style: .default, handler: { (actionItem) in
                    dismiss!(actionItem.tag!)
                })
                
                actionItem.tag = index - 1
                alertVC.addAction(actionItem)
            }
            
            self.topViewController()?.present(alertVC, animated: true, completion: nil)
            return
        }
        
        self.topViewController()?.present(alertVC, animated: true, completion: nil)
    }
    
    /*
     底部弹出
     */
    public class func alertSheet(title: String?, message: String?, buttons: NSArray?, dismiss: DismissBlock? = nil, cancel: CancelBlock? = nil) {
        
        // 提示控制器
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        // 添加控制器上的按钮
        alertVC.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (UIAlertAction) in
            if cancel != nil {
                cancel!()
            }
        }))
        
        if buttons?.count != 0 && buttons != nil {
            // 按钮不止一个
            for index in 1...buttons!.count {
                let btnTitle = String(describing: buttons![index - 1])
                let actionItem = UIAlertAction(title: btnTitle, style: .default, handler: { (actionItem) in
                    if dismiss != nil {
                        dismiss!(actionItem.tag!)
                    }
                })
                
                actionItem.tag = index - 1
                alertVC.addAction(actionItem)
            }
            
            self.topViewController()?.present(alertVC, animated: true, completion: nil)
            return
        }
        self.topViewController()?.present(alertVC, animated: true, completion: nil)
    }
    
}

// MARK: - UIViewController
extension UIViewController {
    // 找到当前显示的window
    class func getCurrentWindow() -> UIWindow? {
        
        // 找到当前显示的UIWindow
        var window: UIWindow? = UIApplication.shared.keyWindow
        /**
         window有一个属性：windowLevel
         当 windowLevel == UIWindowLevelNormal 的时候，表示这个window是当前屏幕正在显示的window
         */
        if window?.windowLevel != UIWindowLevelNormal {
            
            for tempWindow in UIApplication.shared.windows {
                
                if tempWindow.windowLevel == UIWindowLevelNormal {
                    
                    window = tempWindow
                    break
                }
            }
        }
        
        return window
    }
    // MARK: 获取当前屏幕显示的viewController
    class func getCurrentViewController1() -> UIViewController? {
        // 1.声明UIViewController类型的指针
        var viewController: UIViewController?
        
        // 2.找到当前显示的UIWindow
        let window: UIWindow? = self.getCurrentWindow()
        
        // 3.获得当前显示的UIWindow展示在最上面的view
        
        let frontView = window?.subviews.first
        
        // 4.找到这个view的nextResponder
        let nextResponder = frontView?.next
        
        if nextResponder?.isKind(of: UIViewController.classForCoder()) == true {
            
            viewController = nextResponder as? UIViewController
        }
        else {
            viewController = window?.rootViewController
        }
        return viewController
    }
    
    
    class func topViewController() -> UIViewController? {
        
        return self.topViewControllerWithRootViewController(viewController: self.getCurrentWindow()?.rootViewController)
    }
    
    class func topViewControllerWithRootViewController(viewController :UIViewController?) -> UIViewController? {
        
        if viewController == nil {
            
            return nil
        }
        
        if viewController?.presentedViewController != nil {
            
            return self.topViewControllerWithRootViewController(viewController: viewController?.presentedViewController!)
        }
        else if viewController?.isKind(of: UITabBarController.self) == true {
            
            return self.topViewControllerWithRootViewController(viewController: (viewController as! UITabBarController).selectedViewController)
        }
        else if viewController?.isKind(of: UINavigationController.self) == true {
            
            return self.topViewControllerWithRootViewController(viewController: (viewController as! UINavigationController).visibleViewController)
        }
        else {
            
            return viewController
        }
    }
}
