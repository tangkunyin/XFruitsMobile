//
//  XFAboutCompanyViewController.swift
//  XFruits
//
//  Created by tangkunyin on 2017/8/24.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import SnapKit

class XFAboutCompanyViewController: XFBaseSubViewController {

    lazy var aboutImageView: UIImageView = {
        let imageView = UIImageView.init(image: UIImage.imageWithNamed("about_us_static"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "关于我们"
        view.backgroundColor = UIColor.white
        view.addSubview(aboutImageView)
        aboutImageView.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalTo(view)
        }
    }

    

}
