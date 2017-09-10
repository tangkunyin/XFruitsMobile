//
//  XFImageExtension.swift
//  XFruits
//
//  Created by tangkunyin on 2017/4/23.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit

extension UIImage {

    public class func imageWithNamed(_ name:String) -> UIImage {
        let image = UIImage.init(named: name)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        if let renderedImage = image {
            return renderedImage
        }
        // 默认返回空图
        return UIImage()
    }
    
    
    /// 传入base64的字符串，可以是没有经过修改的转换成的以data开头的，也可以是base64的内容字符串，然后转换成UIImage
    ///
    /// - Parameter base64String: base64String description
    /// - Returns: UIImage
    public class func base64StringToUIImage(base64String: String) ->UIImage? {
        var str = base64String
        // 1、判断用户传过来的base64的字符串是否是以data开口的，如果是以data开头的，那么就获取字符串中的base代码，然后在转换，如果不是以data开头的，那么就直接转换
        if str.hasPrefix("data:image") {
            guard let newBase64String = str.components(separatedBy: ",").last else {
                return nil
            }
            str = newBase64String
        }
        // 2、将处理好的base64String代码转换成NSData
        guard let imgNSData = NSData(base64Encoded: str, options: NSData.Base64DecodingOptions()) else {
            return nil
        }
        // 3、将NSData的图片，转换成UIImage
        guard let codeImage = UIImage(data: imgNSData as Data) else {
            return nil
        }
        return codeImage
    }
    
}
