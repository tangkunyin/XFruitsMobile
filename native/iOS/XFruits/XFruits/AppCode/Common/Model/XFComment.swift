//
//  XFComment.swift
//  XFruits
//
//  Created by tangkunyin on 02/07/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import Foundation
import HandyJSON


struct XFComment: HandyJSON {
    var id:Int = 0
    var content:String = ""
    var images:Array<String> = [""]
    var createAt:Int = 0
    var username:String = ""
    var avatar:String = ""
}
