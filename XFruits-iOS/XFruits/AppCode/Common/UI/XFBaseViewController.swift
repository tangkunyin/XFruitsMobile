//
//  XFBaseViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD

class XFBaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    /// 导航栏是否透明
    lazy var clearNavigationBar: Bool = false
    
    /// 当前根视图导航控制器导航条
    lazy var navigationBar: UINavigationBar? = {
        if let navc = self.navigationController {
            return navc.navigationBar
        }
        return nil
    }()
    
    /// 导航条背景视图，通过它可控制导航条颜色
    lazy var navBarBackgroundView: UIView? = {
        if let navBar = self.navigationBar {
            let view = navBar.subviews.first!
            view.backgroundColor = XFConstants.Color.salmon
            view.alpha = self.clearNavigationBar ? 0 : 1
            return view
        }
        return nil
    }()
    
    /// 私有公共组件
    fileprivate lazy var loaddingView: UIImageView = {
        let imageView = UIImageView.init(image: UIImage.imageWithNamed("Loading-transprent"))
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    fileprivate lazy var nullDataView: UIImageView = {
        let imageView = UIImageView.init(image: UIImage.imageWithNamed("order_empty"))
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    fileprivate lazy var nullDataTip: UILabel = {
        let label = UILabel()
        label.font = XFConstants.Font.pfn14
        label.textAlignment = .center
        label.textColor = XFConstants.Color.darkGray
        label.text = "暂无相关内容，请稍后再试..."
        return label
    }()


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let navBar = self.navigationBar,
            let barBackgroundView = self.navBarBackgroundView, clearNavigationBar {
            edgesForExtendedLayout = UIRectEdge(rawValue: 0)
            navBar.isTranslucent = false
            navBar.setBackgroundImage(nil, for: .default)
            navBar.shadowImage = nil
            barBackgroundView.alpha = 1
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        // 默认白色状态栏
        UIApplication.shared.statusBarStyle = .lightContent
        
        if let navBar = self.navigationBar, clearNavigationBar {
            edgesForExtendedLayout = .all
            navBar.isTranslucent = true
            navBar.setBackgroundImage(UIImage(), for: .default)
            navBar.shadowImage = UIImage()
        } else {
            edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        // 打开自带的边缘侧滑返回
        weak var weakSelf = self
        navigationController?.interactivePopGestureRecognizer?.delegate = weakSelf
    }
    
    func renderLoaddingView(){
        removeNullDataView()
        view.addSubview(loaddingView)
        loaddingView.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.size.equalTo(CGSize.init(width: 240, height: 135))
        }
    }
    
    func renderNullDataView(){
        removeLoadingView()
        view.addSubview(nullDataView)
        view.addSubview(nullDataTip)
        nullDataView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(135)
            make.size.equalTo(CGSize.init(width: 100, height: 100))
        }
        nullDataTip.snp.makeConstraints { (make) in
            make.top.equalTo(nullDataView.snp.bottom).offset(10)
            make.centerX.equalTo(nullDataView)
            make.size.equalTo(CGSize.init(width: 300, height: 44))
        }
    }
    
    func removeLoadingView() {
        MBProgressHUD.stopLoadding()
        loaddingView.removeFromSuperview()
    }
    
    func removeNullDataView() {
        MBProgressHUD.stopLoadding()
        nullDataView.removeFromSuperview()
        nullDataTip.removeFromSuperview()
    }
    
    
}


// MARK: - 通过基础型方法扩展
extension XFBaseViewController {

    func loaddingWithMsg(_ msg: String? = "玩儿命加载中...") {
        MBProgressHUD.loaddingWithMessage(msg)
    }
    
    func stopLoadding() {
        MBProgressHUD.stopLoadding()
    }
    
    func showMessage(_ msg: String, completion: (()->Void)? = nil) {
        MBProgressHUD.showMessage(msg, completion: completion)
    }
    
    func showSuccess(_ msg: String = "操作成功") {
        MBProgressHUD.showSuccess(msg)
    }
    
    func showError(_ msg: String = "操作失败") {
        MBProgressHUD.showError(msg)
    }
    
    func showProgress(_ progress: Float, msg: String? = "精彩即将亮相...", mode: MBProgressHUDMode = .annularDeterminate) {
        MBProgressHUD.showProgress(progress, message: msg, mode: mode)
    }
}
