//
//  XFAddress.swift
//  XFruits
//
//  Created by zhaojian on 7/2/17.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//


import HandyJSON

struct XFAddress: HandyJSON {
    
    var id:Int!
    
    var userId:Int?
    
    var recipient:String?
    
    var districtCode:String?
    
    var address:String?
    
    var cellPhone:String?
    
    var isDefault:String?
    
    var label:String?
    
    var expressFee:String?
    
    
}


struct XFAvailableAddressDict:  HandyJSON{
    
    var page:Int?
    var size:Int?
    var content:Array<XFAvailableAddressSingle>?
    
     
}


struct XFAvailableAddressSingle: HandyJSON {
    var code:Int?
    var city:String?
    var county:String?
    var province:String?
}
