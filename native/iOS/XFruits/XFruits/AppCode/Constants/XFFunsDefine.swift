//
//  XFFunsDefine.swift
//  XFruits
//
//  Created by tangkunyin on 2017/4/16.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit

//: 全局颜色函数定义
func colorWithRGB(_ r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor {
    return colorWithRGB(r, g: g, b: b, alpha: 1)
}

func colorWithRGB(_ r:CGFloat,g:CGFloat,b:CGFloat,alpha:CGFloat) -> UIColor {
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
}

func grayColor(_ rgb:CGFloat) -> UIColor {
    return colorWithRGB(rgb, g: rgb, b: rgb, alpha: 1)
}

func randomColorWithAlpha(_ alpha:CGFloat) -> UIColor {
    
    let rValue:CGFloat = CGFloat(Float(arc4random_uniform(255))/255.0)
    let gValue:CGFloat = CGFloat(Float(arc4random_uniform(255))/255.0)
    let bValue:CGFloat = CGFloat(Float(arc4random_uniform(255))/255.0)
    
    return colorWithRGB(rValue, g: gValue, b: bValue, alpha: alpha)
}

//: 全局颜色函数定义
func sysFontWithSize(_ size:CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size)
}

func pfnFontWithSize(_ size:CGFloat) -> UIFont {
    return UIFont.init(name: "PingFangSC-Regular", size: size)!
}

func pfbFontWithSize(_ size:CGFloat) -> UIFont {
    return UIFont.init(name: "PingFangSC-Thin", size: size)!
}

func htscFontWithSize(_ size:CGFloat) -> UIFont {
    return UIFont.init(name: "Heiti SC", size: size)!
}


