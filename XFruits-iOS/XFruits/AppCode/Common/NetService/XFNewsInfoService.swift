//
//  XFNewsInfoService.swift
//  XFruits
//
//  Created by tangkunyin on 2017/8/19.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import Foundation
import Alamofire
import HandyJSON
import SwiftyJSON


/// 目前用于首页轮播图、新闻列表数据
class XFNewsInfoService: XFNetworking {

    /// 获取首页列表
    func getNewsList(params: Dictionary<String, Any>, _ completion:@escaping XFResponse) {
        self.doGet(withUrl: url("/index/show", params: params)) { (success, respData) in
            if success, respData is NSDictionary, let dict = respData as? NSDictionary {
                completion(XFNewsInfo.deserialize(from: dict) ?? XFNewsInfo())
            }
        }
    }
    
    /// 获轮播图集
    func getLoopImages(_ completion:@escaping XFResponse) {
        self.doGet(withUrl: url("/index/loopImg")) { (success, respData) in
            if success, respData is Array<Any>, let list = respData as? Array<Any> {
                completion([XFIndexLoopImage].deserialize(from: JSON(list).rawString()) ?? [])
            }
        }
    }
    
    
}
