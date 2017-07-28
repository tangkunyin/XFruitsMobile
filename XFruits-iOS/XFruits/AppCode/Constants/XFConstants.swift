//
//  XFConstants.swift
//  XFruits
//
//  Created by tangkunyin on 2017/4/16.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit

/**
 *   所有全局常量均在此处定义
 *   使用方式如：XFConstants.UI.deviceWidth 即可取得设备宽
 */
struct XFConstants {
    
    
    /// 开发模式
    static let isDevelopModel:Bool = true
    
    /// 详情页商品评论数控制，默认最多展示三条
    static let detailCommentsLimit:Int = 3
    
    /// DES3 KEY (必须是24位)
    static let desKey:String = "123456781234567812345678"
    
    /// MD5 KEY (8位)
    static let md5Key:String = "88888888"
    
    /// 分页每页的条数
    static let pageRows:Int = 10
    
    struct SDK {
        struct V5KF {
            static let siteId = "145039"
            static let appId = "2368f0801ca49"
        }
    }
    
    
    /// 事件消息key定义
    struct MessageKey {
        // 请求更新果篮数据
        static let NeedRefreshShopCartData: String = "_needRefreshShopCartData"
    }
    
    
    /// APP 3D Touch 快捷键Type
    struct ShortCut {
        static let Express = "xfruits.shortCut.express"
        static let Contact = "xfruits.shortCut.contact"
        static let Share = "xfruits.shortCut.share"
    }
    
    /// 通用UI尺寸
    struct UI {
        
        static let deviceWidth: CGFloat = UIScreen.main.bounds.size.width
        
        static let deviceHeight: CGFloat = UIScreen.main.bounds.size.height
        
        static let fullScreenRect: CGRect = CGRect(x: 0, y: 0, width: deviceWidth, height: deviceHeight)
        
        static let fullVCRect: CGRect = CGRect(x: 0, y: 0, width: deviceWidth, height: deviceHeight - 64)
        
        static let fullTabbarVCRect: CGRect = CGRect(x: 0, y: 0, width: deviceWidth, height: deviceHeight - 64 - 49)
        
        static let singleLineAdjustOffset: CGFloat = ((1 / UIScreen.main.scale) / 2)
        
    }
    
    /// 视觉规范
    struct Color {
        /// 通用颜色
        static let white:UIColor = colorWithRGB(255, g: 255, b: 255)            //纯白
        static let darkGray:UIColor = colorWithRGB(102, g: 102, b: 102)         //深灰(通用字体)
        static let commonBackground:UIColor = colorWithRGB(248, g: 248, b: 248) //灰白色
        static let separatorLine:UIColor = colorWithRGB(232, g: 232, b: 232)    //分割线颜色
        static let tranparent:UIColor = colorWithRGB(0,g: 0,b: 0, alpha: 0.55)  //半透明颜色
        /// App主题色
        static let lightishGreen:UIColor = colorWithRGB(68,g: 219,b: 94)//亮绿色
        static let orangeRed:UIColor = colorWithRGB(254,g: 56,b: 36)//橙红色
        static let tangerine:UIColor = colorWithRGB(255,g: 150,b: 0)//浅橙色
        static let skyBlue:UIColor = colorWithRGB(84,g: 199,b: 252)//天蓝色
        static let sunflowerYellow:UIColor = colorWithRGB(255,g: 205,b: 0)//浅黄色
        static let reddishPink:UIColor = colorWithRGB(254,g: 40,b: 81)//红色
        static let purpleyGrey:UIColor = colorWithRGB(143,g: 142,b: 148)//灰色
        static let brightBlue:UIColor = colorWithRGB(0,g: 118,b: 255)//亮蓝色
        static let black:UIColor = colorWithRGB(3,g: 3,b: 3)//黑色
        static let paleGrey:UIColor = colorWithRGB(239,g: 239,b: 244)//浅灰色
        static let coolGrey:UIColor = colorWithRGB(164,g: 170,b: 179)//亮灰色
        static let silver:UIColor = colorWithRGB(199,g: 199,b: 205)//银色
        static let greyishBrown:UIColor = colorWithRGB(83,g: 83,b: 83)//浅黑色
        static let salmon:UIColor = colorWithRGB(255,g: 102,b: 102)//苹果红
        static let pinkishGrey:UIColor = colorWithRGB(204, g: 204, b: 204)//分割线灰色
    }
    
    /// 通用字体
    struct Font {
        static let mainBodyFont: UIFont = pfnFontWithSize(12)
        static let mainMenuFont: UIFont = pfnFontWithSize(14)
        static let titleFont: UIFont = pfnFontWithSize(18)
        static let bottomMenuFont: UIFont = pfnFontWithSize(10)
    }
    
}


