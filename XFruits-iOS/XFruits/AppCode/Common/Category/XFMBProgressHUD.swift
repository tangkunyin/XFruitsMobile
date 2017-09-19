
//
//  XFMBProgressHUD.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import MBProgressHUD

fileprivate enum MBProgressTipType:Int {
    case tipNone       //无提示符
    case tipSuccess    //正确提示符
    case tipError      //错误提示符
}

extension MBProgressHUD {
    
    //MARK: - 操作提示
    public class func showError(_ error:String? = "操作失败"){
        self.show(text: error, type: .tipError, completion: nil)
    }
    
    public class func showSuccess(_ success:String? = "操作成功"){
        self.show(text: success, type: .tipSuccess, completion: nil)
    }
    
    //MARK: - 菊花加载
    public class func startLoadding(){
        self.loaddingWithMessage(nil)
    }
    public class func stopLoadding(){
        self.hideHUDForView()
    }
    public class func loaddingWithMessage(_ message:String?){
        let window = UIApplication.shared.keyWindow
        if let window = window,
            let loadingView = window.subviews.last,!(loadingView is MBProgressHUD) {
            let mbHub = MBProgressHUD.showAdded(to: window, animated: true)
            mbHub.removeFromSuperViewOnHide = true
            mbHub.mode = .indeterminate
            mbHub.bezelView.color = grayColor(200)
            mbHub.bezelView.style = .solidColor
            mbHub.detailsLabel.text = message
            mbHub.detailsLabel.textColor = colorWithRGB(83,g: 83,b: 83)
            UIActivityIndicatorView.appearance(whenContainedInInstancesOf: [MBProgressHUD.self]).color = grayColor(68)
        }
    }
    
    
    //MARK: - 进度条显示。默认圆圈
    public class func showProgress(_ fractionCompleted:Float){
        self.showProgress(fractionCompleted, message: nil)
    }
    public class func showProgress(_ fractionCompleted:Float, message:String?){
        self.showProgress(fractionCompleted, message: message, mode: .annularDeterminate)
    }
    public class func showProgress(_ fractionCompleted:Float, message:String?, mode:MBProgressHUDMode){
        DispatchQueue.main.async {
            if let window = UIApplication.shared.keyWindow,MBProgressHUD.hide(for: window, animated: false) {
                let mbHub = MBProgressHUD.showAdded(to: window, animated: true)
                mbHub.mode = mode;
                mbHub.bezelView.color = grayColor(200)
                mbHub.label.textColor = colorWithRGB(83,g: 83,b: 83)
                if fractionCompleted == 1.0 {
                    mbHub.hide(animated: true)
                }else{
                    mbHub.progress = fractionCompleted;
                    mbHub.label.text = message;
                }
            }
        }
    }
    
    //MARK: - 提示后响应某个动作
    public class func showMessage(_ message:String?, completion:(()->Void)?){
        self.show(text: message, type: .tipNone, completion: completion)
    }
    
    //MARK: - 私有方法
    fileprivate class func hideHUDForView(_ view:UIView? = UIApplication.shared.keyWindow?.subviews.last){
        if let view = view {
            if !MBProgressHUD.hide(for: view, animated: true) && view is MBProgressHUD {
                Thread.sleep(forTimeInterval: 0.4)
                view.removeFromSuperview()
            }
        }
    }
    
    
    fileprivate class func show(text:String? ,type:MBProgressTipType, completion:(()->Void)?){
        if let window = UIApplication.shared.keyWindow,
            let text = text, text.characters.count > 0 {
            self.hideHUDForView(window)
            let mbHub = MBProgressHUD.showAdded(to: window, animated: true)
            mbHub.bezelView.color = grayColor(200)
            mbHub.detailsLabel.text = text
            mbHub.detailsLabel.textColor = colorWithRGB(83,g: 83,b: 83)
            mbHub.removeFromSuperViewOnHide = true
            mbHub.mode = MBProgressHUDMode.customView
            switch (type) {
            case .tipNone:
                mbHub.mode = MBProgressHUDMode.text
            case .tipSuccess:
                mbHub.customView = UIImageView(image: UIImage.imageWithNamed("Checkmark-success"))
            case .tipError:
                mbHub.customView = UIImageView(image: UIImage.imageWithNamed("Checkmark-error"))
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.6, execute: {
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.2, animations: {
                        mbHub.transform = CGAffineTransform(scaleX: 0.8, y: 0.8);
                    }, completion: { (finish) in
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.2, execute: {
                            mbHub.removeFromSuperview()
                            if let completion = completion {
                                completion();
                            }
                        })
                    })
                }
            })
            
        }
    }
}

