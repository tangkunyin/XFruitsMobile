//
//  XFBaseResponse.swift
//  XFruits
//
//  Created by tangkunyin on 04/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import HandyJSON

struct XFBaseResponse: HandyJSON {

    public var code:XFHttpStatusCode = .success
    
    var msg:String = ""
    
    var data:Any?
        
}
