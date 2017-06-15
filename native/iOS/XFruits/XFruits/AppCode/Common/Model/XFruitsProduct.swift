//
//  XFruitsProduct.swift
//  XFruits
//
//  Created by tangkunyin on 11/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import HandyJSON

struct ProductType: HandyJSON {
    var id:Int = 1001
    var name:String = ""
    var fruit:String = ""
    var image:String = ""
}

struct ProductItem: HandyJSON {
    var id:Int = 1001
    var name:String = ""
    var cover:String = ""
    var primePrice:Float = 0
    var salesPrice:Float = 0
    // 以下属性为果篮专用
    var index:Int = 0
    var quantity:Int = 0
    var selected:Bool = false
    
}

struct ProductDetail: HandyJSON {
    var id:Int = 1001
    var name:String = ""
    var fruit:String = ""
    var cover:String = ""
    var specification:String = ""
    var primePrice:Float = 0
    var salesPrice:Float = 0
    var description:String = ""
    var service:String = ""
    var commentList:Array<XFruitsCommen>?
}

