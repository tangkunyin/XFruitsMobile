//
//  XFUser.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import Foundation
import HandyJSON

struct UserRank: HandyJSON {
    var userId:Int?
    var rank:Int?
    var exp:Int?
}

/// 用户模型
struct XFUser: HandyJSON {

    var id:Int?
    
    // 用户名称
    var username:String = ""
    
    // 手机号
    var cellPhone:String = ""
    
    // 用户性别
    var sex:Int?
    
    //用户头像URL
    var avatar:String?
    
    // token，等同于用户唯一标识，30天过期不是固定的
    var token:String?
    
    // email
    var email:String?
    
    var rank:UserRank?
    
}
