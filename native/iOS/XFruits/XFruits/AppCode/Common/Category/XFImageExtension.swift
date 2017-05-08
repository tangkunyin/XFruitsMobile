//
//  XFImageExtension.swift
//  XFruits
//
//  Created by tangkunyin on 2017/4/23.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit

extension UIImage {

    public class func imageWithNamed(_ name:String) -> UIImage{
        let image = UIImage.init(named: name)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        return image!;
    }
    
}