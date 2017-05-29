
//
//  XFButtonExtension.swift
//  XFruits
//
//  Created by tangkunyin on 29/05/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import UIKit

// 按钮中的图文混排类型
public enum BtnImgDirectionType {
    case left   //默认：图片居左，文字居右。整体左右结构
    case right  //图片居右，文字居左。整体左右机构
    case top    //图片居上，文字居下。整体上下机构
    case bottom //图片居下，文字居上。整体上下机构
}

extension UIButton {
    
    
    /// 按钮中的图文混排
    ///
    /// - Parameters:
    ///   - title: 按钮标题
    ///   - imageName: 按钮icon图
    ///   - textColor: 标题颜色
    ///   - textFont: 标题字体
    ///   - directionType: 图文混排中图的位置类型
    ///   - chAlignment: 内容水平排列方式
    ///   - cvAlignment: 内容垂直排列方式
    ///   - cEdgeInsets: 内容边距
    ///   - span: 图标和文本间距
    ///   - target: 响应者
    ///   - action: 事件名称
    /// - Returns: 图文混排后的按钮
    public class func buttonWithTitle(_ title:String,
                                      imageName:String,
                                      textColor:UIColor,
                                      textFont:UIFont,
                                      directionType:BtnImgDirectionType,
                                      chAlignment:UIControlContentHorizontalAlignment,
                                      cvAlignment:UIControlContentVerticalAlignment,
                                      cEdgeInsets:UIEdgeInsets,
                                      span:CGFloat,
                                      target:Any?,
                                      action:Selector?) -> UIButton{
        let btn = UIButton.init(type: .custom)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(textColor, for: .normal)
        btn.titleLabel?.font = textFont
        btn.setImage(UIImage.imageWithNamed(imageName), for: .normal)
        btn.contentHorizontalAlignment = chAlignment
        btn.contentVerticalAlignment = cvAlignment
        btn.contentEdgeInsets = cEdgeInsets
        if let imageSize = btn.imageView?.frame.size,let titleSize = btn.titleLabel?.frame.size {
            let totalWidth = (imageSize.width + titleSize.width) + span
            let totalHeight = (imageSize.height + titleSize.height) + span
            switch (directionType) {
            case .left:
                if (.right == chAlignment) {
                    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, span)
                }else{
                    btn.titleEdgeInsets = UIEdgeInsetsMake(0, span, 0, 0)
                }
            case .right:
                btn.imageEdgeInsets = UIEdgeInsetsMake(0, (totalWidth - imageSize.width) , 0, -titleSize.width)
                btn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width , 0, (totalWidth - titleSize.width))
            case .top:
                btn.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imageSize.height), 0, 0, -titleSize.width)
                btn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, -(totalHeight - titleSize.height),0)
            case .bottom:
                btn.imageEdgeInsets = UIEdgeInsetsMake((totalHeight - imageSize.height), 0, 0, -titleSize.width)
                btn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, (totalHeight - titleSize.height),0)
            }
            
        }
        if let target = target,let action = action {
            btn.addTarget(target, action: action, for: .touchUpInside)
        }
        return btn
    }
    
}
