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
    lazy var navigationBar: UINavigationBar = {
        let navBar = self.navigationController?.navigationBar
        return navBar!
    }()
    
    /// 导航条背景视图，通过它可控制导航条颜色
    lazy var navBarBackgroundView: UIView = {
        let view = self.navigationBar.subviews.first!
        view.backgroundColor = XFConstants.Color.salmon
        view.alpha = self.clearNavigationBar ? 0 : 1
        return view
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if clearNavigationBar {
            edgesForExtendedLayout = UIRectEdge(rawValue: 0)
            navigationBar.isTranslucent = false
            navigationBar.setBackgroundImage(nil, for: .default)
            navigationBar.shadowImage = nil
            navBarBackgroundView.alpha = 1
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if clearNavigationBar {
            edgesForExtendedLayout = .all
            navigationBar.isTranslucent = true
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
        } else {
            edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        
    }
    
}
