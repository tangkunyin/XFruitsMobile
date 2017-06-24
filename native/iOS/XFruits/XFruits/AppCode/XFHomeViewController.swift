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
        
        self.addAllChildViewControllers()
    }
    
    
    private func addAllChildViewControllers() {
        //首页
        let indexVC = XFIndexViewController()
        self.addChildViewController(indexVC, title: "首页", image: "home", selectedImage: "home-hilight")
        
        //分类
        let categoryVC = XFCategoryViewController()
        self.addChildViewController(categoryVC, title: "所有", image: "category", selectedImage: "category-hilight")
        
        //购物车
        let cartVC = XFShopCarViewController()
        self.addChildViewController(cartVC, title: "果篮", image: "shopcart", selectedImage: "shopcart-hilight")
        
        //用户中心
        let userVC = XFUserCenterViewController()
        self.addChildViewController(userVC, title: "我的", image: "userCenter", selectedImage: "userCenter-hilight")
        
    }
    
    
    private func addChildViewController(_ childController:UIViewController,
                                        title:String,
                                        image:String,
                                        selectedImage:String) {
        
        childController.tabBarItem = UITabBarItem.init(title: title,
                                                       image: UIImage.imageWithNamed(image),
                                                       selectedImage: UIImage.imageWithNamed(selectedImage))
        
        let normalAttr = [NSForegroundColorAttributeName:XFConstants.Color.greyishBrown,
                          NSFontAttributeName:XFConstants.Font.bottomMenuFont]
        let hilighAttr = [NSForegroundColorAttributeName:XFConstants.Color.salmon,
                          NSFontAttributeName:XFConstants.Font.bottomMenuFont]
        
        childController.tabBarItem.setTitleTextAttributes(normalAttr, for: UIControlState.normal)
        childController.tabBarItem.setTitleTextAttributes(hilighAttr, for: UIControlState.selected)
        
        childController.title = title;
        
        let nav = XFNavigationController.init(rootViewController: childController)
        
        self.addChildViewController(nav)
    }
    
    
}

