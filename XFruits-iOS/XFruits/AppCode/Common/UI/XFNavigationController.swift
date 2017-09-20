//
//  XFNavigationController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

class XFNavigationController: UINavigationController {
    
    fileprivate static let initAppearance: Void = {
        
        let bar = UINavigationBar.appearance()
        bar.tintColor = UIColor.white
        bar.isTranslucent = false
        bar.barTintColor = XFConstants.Color.salmon
        bar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:XFConstants.Color.white,
                                   NSAttributedStringKey.font:XFConstants.Font.pfn18]
    
        let barButtonItem = UIBarButtonItem.appearance()
        barButtonItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:XFConstants.Color.white,
                                              NSAttributedStringKey.font:XFConstants.Font.pfn18],
                                             for: UIControlState.normal)
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
