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
    
    fileprivate func addChildViewControllers() {
        addChildViewController(indexVC, title: "鲜景", image: "home-normal", selectedImage: "home-highlight")

        addChildViewController(categoryVC, title: "水货", image: "all-normal", selectedImage: "all-highlight")
        
        addChildViewController(cartVC, title: "果篮", image: "shopCart-normal", selectedImage: "shopCart-highlight")
        
        addChildViewController(userVC, title: "你的", image: "mine-normal", selectedImage: "mine-hightlight")
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
        
        let normalAttr = [NSForegroundColorAttributeName:XFConstants.Color.greyishBrown,
                          NSFontAttributeName:XFConstants.Font.pfn10]
        let hilighAttr = [NSForegroundColorAttributeName:XFConstants.Color.salmon,
                          NSFontAttributeName:XFConstants.Font.pfn12]
        
        childController.tabBarItem.setTitleTextAttributes(normalAttr, for: UIControlState.normal)
        childController.tabBarItem.setTitleTextAttributes(hilighAttr, for: UIControlState.selected)
        childController.title = title
        
        let nav = XFNavigationController.init(rootViewController: childController)
        
        self.addChildViewController(nav)
    }
}

