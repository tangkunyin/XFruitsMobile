
//
//  XFProduct.swift
//  XFruits
//
//  Created by tangkunyin on 24/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import Foundation
import HandyJSON

class ProductType: HandyJSON {
    var id:String = "1001"
    var name:String = ""
    var fruit:String = ""
    var image:String = ""
    required init() {}
}

class ProductItem: HandyJSON {
    var id:String?
    var name:String = ""
    var fruit:String = ""
    var cover:String = ""
    var specification:String = ""
    var primePrice:Float = 0
    var salesPrice:Float = 0
    
    required init() {}
}

class CategoryList: HandyJSON {
    var size:Int?
    var totalPages:Int?
    var totalElements:Int?
    var content:Array<ProductItem>?
    required init() {}
}

class ProductDetailService: HandyJSON {
    var ico:String = ""
    var name:String = ""
    required init() {}
}

class ProductDetail: HandyJSON {
    var id:String = "1001"
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
    
    required init() {}
    
    func convertToProductItem() -> ProductItem {
        let item = ProductItem()
        item.id = self.id
        item.name = self.name
        item.fruit = self.fruit
        item.cover = self.cover.first!
        item.specification = self.specification
        item.primePrice = self.primePrice
        item.salesPrice = self.salesPrice
        return item
    }
}

