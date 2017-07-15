//
//  XFNavigationController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class XFNavigationController: UINavigationController {
    
    private static let initAppearance: Void = {
        let barAttr = [NSForegroundColorAttributeName:XFConstants.Color.white,
                       NSFontAttributeName:XFConstants.Font.titleFont];
        
        let bar = UINavigationBar.appearance()
        
        bar.tintColor = UIColor.white
        bar.barTintColor = XFConstants.Color.salmon
        bar.titleTextAttributes = barAttr;
        
        let barButtonItem = UIBarButtonItem.appearance()
        barButtonItem.setTitleTextAttributes(barAttr, for: UIControlState.normal)
    }()
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        XFNavigationController.initAppearance
        
        
    }
    
}

