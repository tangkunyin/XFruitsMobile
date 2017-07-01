
//
//  XFProduct.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import Foundation
import HandyJSON

struct ProductType: HandyJSON {
    var id:Int = 1001
    var name:String = ""
    var fruit:String = ""
    var image:String = ""
}

struct ProductItem: HandyJSON {
    var id:Int?
    var name:String = ""
    var fruit:Int?
    var cover:String = ""
    var specification:String = ""
    var primePrice:Float = 0
    var salesPrice:Float = 0
}

struct CategoryList: HandyJSON {
    var size:Int?
    var totalPages:Int?
    var totalElements:Int?
    var content:Array<ProductItem>?
}

struct ProductDetailService: HandyJSON {
    var ico:String = ""
    var name:String = ""
}

struct ProductDetail: HandyJSON {
    var id:Int = 1001
    var name:String = ""
    var fruit:String = ""
    var cover:Array<String> = [""]
    var specification:String = ""
    var primePrice:Float = 0
    var salesPrice:Float = 0
    var description:Array<String> = [""]
    var priority:Int = 0
    var service:Array<ProductDetailService>?
    var commentList:Array<XFComment>?
}

