//
//  XFAddress.swift
//  XFruits
//
//  Created by zhaojian on 7/2/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//


import HandyJSON

struct XFAddress: HandyJSON {
    var id:String = ""
    var userId:String = ""
    var recipient:String = ""
    var districtCode:String = ""
    var districtName:String = ""
    var address:String = ""
    var cellPhone:String = ""
    var isDefault:Int = 0
    var label:String = ""
    var expressFee:Float?
}

struct XFAddressJson: HandyJSON{
    var district:Array<XFAddressDistrict>?
    var md5:String?
}
struct XFAddressDistrict: HandyJSON{
    var name:String?
    var code:Int?
    var expressFee:Int?

    var district:Array<XFFirstDistrict>?
//    var md5:String?
}


struct XFFirstDistrict:  HandyJSON {
    var name:String?
    
    var subDistrict:Array<XFSubDistrict>?
}


struct XFSubDistrict: HandyJSON {
    var name:String?
    var code:Int?
    var expressFee:Int?
    
    
    
}
