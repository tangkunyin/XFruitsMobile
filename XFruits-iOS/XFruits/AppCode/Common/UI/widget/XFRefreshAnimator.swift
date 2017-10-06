//
//  XFRefreshAnimator.swift
//  XFruits
//
//  Created by tangkunyin on 2017/10/5.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit
import ESPullToRefresh

final class XFRefreshAnimator {
    
    class func header() -> ESRefreshHeaderAnimator {
        let headerAnimator = ESRefreshHeaderAnimator()
        headerAnimator.pullToRefreshDescription = "下拉可加载最新数据"
        headerAnimator.loadingDescription = "玩命加载中..."
        headerAnimator.releaseToRefreshDescription = "松手马上获取最新数据"
        return headerAnimator
    }
    
    class func footer() -> ESRefreshFooterAnimator {
        let footerAnimator = ESRefreshFooterAnimator()
        footerAnimator.loadingMoreDescription = "上拉获取更多数据"
        footerAnimator.loadingDescription = "玩命加载中..."
        footerAnimator.noMoreDataDescription = "数据已加载完毕"
        return footerAnimator
    }
    
}
