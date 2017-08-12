
//
//  XFBaseSubViewController.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit


/// 返回按钮背景图外部Key
struct XFBackButtonImages {
    static let normal: String = "normal"
    static let highlighted: String = "highlighted"
    static let defaultSets: Dictionary<String, String> = ["normal":"navi_back_white_nor","highlighted":"navi_back_white_pre"]
}


class XFBaseSubViewController: XFBaseViewController {
    
    var backToRoot: Bool = false
    
    /// 改变返回按钮ICON，直接设置值
    var backButtonImages: Dictionary<String, String> {
        get {
            // 默认返回icon
            return XFBackButtonImages.defaultSets
        }
        set (newBackImages) {
            if let normalImage = newBackImages[XFBackButtonImages.normal],
                let hilightImage = newBackImages[XFBackButtonImages.highlighted] {
                backBtn.setImage(UIImage.imageWithNamed(normalImage), for: .normal)
                backBtn.setImage(UIImage.imageWithNamed(hilightImage), for: .highlighted)
                if let size = backBtn.image(for: .normal)?.size {
                    backBtn.frame = CGRect.init(origin: CGPoint.zero, size: size)
                }
            }
        }
    }
    
    lazy var backBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        let images: Dictionary<String, String> = self.backButtonImages
        btn.setImage(UIImage.imageWithNamed(images[XFBackButtonImages.normal]!), for: .normal)
        btn.setImage(UIImage.imageWithNamed(images[XFBackButtonImages.highlighted]!), for: .highlighted)
        btn.addTarget(self, action: #selector(backToParentController), for: .touchUpInside)
        if let size = btn.image(for: .normal)?.size {
            btn.frame = CGRect.init(origin: CGPoint.zero, size: size)
        }
        return btn
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        // 统一设置所有返回图标为白色
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.hidesBackButton = true
        
        // 统一返回按钮样式
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backBtn)
        
        
    }
    
    
    @objc func backToParentController() {
        if let navController = self.navigationController {
            if navController.responds(to: #selector(navController.popViewController(animated:))) {
                if backToRoot {
                    navController.popToRootViewController(animated: true)
                } else {
                    navController.popViewController(animated: true)
                }
            }
        }
    }
}

