//
//  XFBaseViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class XFBaseViewController: UIViewController {
    
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
        
        
    }
    
}
