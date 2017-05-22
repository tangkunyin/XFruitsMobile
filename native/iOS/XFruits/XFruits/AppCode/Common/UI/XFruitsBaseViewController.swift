//
//  XFruitsBaseViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/4/9.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit

class XFruitsBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        navigationController?.navigationBar.tintColor = UIColor.white
        
    }

    
}
