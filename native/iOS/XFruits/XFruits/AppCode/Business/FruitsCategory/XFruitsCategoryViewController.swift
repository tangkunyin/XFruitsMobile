//
//  XFruitsCategoryViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/4/9.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import MBProgressHUD

class XFruitsCategoryViewController: XFruitsBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.imageWithNamed("msg-icon"),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(onMoreItemClick))

        
    }

    
    @objc private func onMoreItemClick(){
        
        let allVC = XFAllCategoryListViewController()
        navigationController?.pushViewController(allVC, animated: true)
    
    }

    

}
