//
//  XFIndex.swift
//  XFruits
//
//  Created by tangkunyin on 2017/8/19.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import Foundation
import HandyJSON

class XFNewsContent: HandyJSON {
    var id: Int = 0
    var type: Int = 0
    var title: String = ""
    var desc: String = ""
    var cover: String = ""
    var data: String = ""
    var sort: Int = 0
    
    required init() {}
}

class XFNewsInfo: HandyJSON {
    var page: Int = 0
    var size: Int = 0
    var totalElements: Int = 0
    var totalPages: Int = 0
    var content: Array<XFNewsContent>?
    
    required init() {}
}


class XFIndexLoopImage: HandyJSON {
    var id: Int = 0
    var position: Int = 0
    var type: Int = 0
    var title: String = ""
    var desc: String = ""
    var cover: String = ""
    var data: String = ""
    var sort: Int = 0
    
    required init() {}
}
