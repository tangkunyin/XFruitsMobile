//
//  XFruitsBaseRequest.swift
//  XFruits
//
//  Created by tangkunyin on 2017/4/9.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import UIKit

class XFruitsBaseRequest: NSObject {

    public var code:XFHttpStatusCode?
    
    var msg:String?
    
    var data:Any?
 
    public required override init() {}
    
}
