//
//  XFruitsHomeViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/4/9.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit

class XFruitsHomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addAllChildViewControllers()
    }

    
    private func addAllChildViewControllers() {
        //首页
        let indexVC = XFruitsIndexViewController()
        self.addChildViewController(indexVC, title: "首页", image: "home", selectedImage: "home-hilight")
        
        //分类
        let categoryVC = XFruitsCategoryViewController()
        self.addChildViewController(categoryVC, title: "所有", image: "category", selectedImage: "category-hilight")
        
        //购物车
        let cartVC = XFruitsShopCarViewController()
        self.addChildViewController(cartVC, title: "果篮", image: "shopcart", selectedImage: "shopcart-hilight")
        
        //用户中心
        let userVC = XFruitsUserCenterViewController()
        self.addChildViewController(userVC, title: "我的", image: "userCenter", selectedImage: "userCenter-hilight")
        
    }
    

    private func addChildViewController(_ childController:UIViewController,
                                        title:String,
                                        image:String,
                                        selectedImage:String) {
                
        childController.tabBarItem = UITabBarItem.init(title: title,
                                                       image: UIImage.init(named: image),
                                                       selectedImage: UIImage.init(named: selectedImage))
        
        let normalAttr = [NSForegroundColorAttributeName:XFConstants.Color.blackColor,
                          NSFontAttributeName:XFConstants.Font.bottomMenuFont]
        let hilighAttr = [NSForegroundColorAttributeName:XFConstants.Color.orangeColor,
                          NSFontAttributeName:XFConstants.Font.bottomMenuFont]
        
        childController.tabBarItem.setTitleTextAttributes(normalAttr, for: UIControlState.normal)
        childController.tabBarItem.setTitleTextAttributes(hilighAttr, for: UIControlState.selected)
        
        childController.title = title;
        
        let nav = XFruitsNavigationController.init(rootViewController: childController)

        self.addChildViewController(nav)
    }
    

}
