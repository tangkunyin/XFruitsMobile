//
//  XFEnum.swift
//  XFruits
//
//  Created by tangkunyin on 2017/4/22.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import Foundation
import HandyJSON

/**
 
 首页show 数据， type: 类型，1网页，2音频，3视频，4产品，5广告
 type 不一样， data 字段的数据就不一样
 目前， 除了 4 产品  这个类型， 其他的 data 都是一个 url
 首页轮播图， 同上
 
 */
public enum XFIndexConentType: Int {
    case html = 1
    case audio = 2
    case video = 3
    case product = 4
    case advertising = 5
}
