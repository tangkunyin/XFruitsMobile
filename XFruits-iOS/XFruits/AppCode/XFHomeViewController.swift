//
//  XFHomeViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit


class XFHomeViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewControllers()
    }
    
    
    
    private func addChildViewControllers() {
    
        /// 根据用户级别开放首页
        if XFUserGlobal.shared.isLogin && XFUserGlobal.shared.currentUser?.vip == 10 {
            //首页
            let indexVC = XFIndexViewController()
            addChildViewController(indexVC, title: "首页", image: "home", selectedImage: "home-hilight")
        }
        
        //分类
        let categoryVC = XFCategoryViewController()
        addChildViewController(categoryVC, title: "所有", image: "category", selectedImage: "category-hilight")
        
        //购物车
        let cartVC = XFShopCarViewController()
        addChildViewController(cartVC, title: "果篮", image: "shopcart", selectedImage: "shopcart-hilight")
        
        //用户中心
        let userVC = XFUserCenterViewController()
        addChildViewController(userVC, title: "我的", image: "userCenter", selectedImage: "userCenter-hilight")
    }
    
    
    private func addChildViewController(_ childController:UIViewController,
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

