//
//  XFHomeViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class XFHomeViewController: UITabBarController {
    
    //首页
    var indexVC: XFBaseViewController {
        get {
            return XFIndexViewController()
        }
    }
    
    //分类
    var categoryVC: XFBaseViewController {
        get {
            return XFCategoryViewController()
        }
    }
    
    //购物车
    var cartVC: XFBaseViewController {
        get {
            return XFShopCarViewController()
        }
    }
    
    //用户中心
    var userVC: XFBaseViewController {
        get {
            return XFUserCenterViewController()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewControllers()
    }
    
    private func addChildViewControllers() {
        /// 根据用户级别开放首页
        if XFUserGlobal.shared.isLogin && XFUserGlobal.shared.currentUser?.vip == 10 {
            addChildViewController(indexVC, title: "首页", image: "home", selectedImage: "home-hilight")
        }
        
        addChildViewController(categoryVC, title: "分类", image: "category", selectedImage: "category-hilight")
        
        addChildViewController(cartVC, title: "果篮", image: "shopcart", selectedImage: "shopcart-hilight")
        
        addChildViewController(userVC, title: "我的", image: "userCenter", selectedImage: "userCenter-hilight")
    }
    
}

extension XFHomeViewController {
    fileprivate func addChildViewController(_ childController:UIViewController,
                                            title:String,
                                            image:String,
                                            selectedImage:String) {
        
        childController.tabBarItem = UITabBarItem.init(title: title,
                                                       image: UIImage.imageWithNamed(image),
                                                       selectedImage: UIImage.imageWithNamed(selectedImage))
        
        let normalAttr = [NSAttributedStringKey.foregroundColor:XFConstants.Color.greyishBrown,
                          NSAttributedStringKey.font:XFConstants.Font.bottomMenuFont]
        let hilighAttr = [NSAttributedStringKey.foregroundColor:XFConstants.Color.salmon,
                          NSAttributedStringKey.font:XFConstants.Font.bottomMenuFont]
        
        childController.tabBarItem.setTitleTextAttributes(normalAttr, for: UIControlState.normal)
        childController.tabBarItem.setTitleTextAttributes(hilighAttr, for: UIControlState.selected)
        
        childController.title = title;
        
        let nav = XFNavigationController.init(rootViewController: childController)
        
        self.addChildViewController(nav)
    }
}

