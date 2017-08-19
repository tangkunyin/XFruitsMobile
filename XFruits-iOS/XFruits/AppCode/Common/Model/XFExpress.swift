//
//  XFExpress.swift
//  XFruits
//
//  Created by tangkunyin on 2017/8/19.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import Foundation
import HandyJSON

struct XFExpressUnit: HandyJSON {
    var time: String = ""
    var info: String = ""
}

struct XFExpress: HandyJSON {
    var expressCode: String = ""
    var expressName: String = ""
    var trackingNum: String = ""
    var trackingInfoList: Array<XFExpressUnit>?
}
