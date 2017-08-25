
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
    var id:Int = 1000
    var name:String = ""
    var image:String = ""
    required init() {}
}

class ProductItem: HandyJSON {
    var id:String?
    var name:String = ""
    var cover:String = ""
    var specification:String = ""
    var primePrice:Float = 0
    required init() {}
}

class CategoryList: HandyJSON {
    var page:Int?
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
    var id:String = ""
    var name:String = ""
    var specification:String = ""
    var primePrice:Float = 0
    var priority:Int = 0
    var cover:Array<String> = [""]
    var description:Array<String> = [""]
    var service:Array<ProductDetailService>?
    var commentList:Array<XFComment>?
    
    required init() {}
    
    func convertToProductItem() -> ProductItem {
        let item = ProductItem()
        item.id = self.id
        item.name = self.name
        item.cover = self.cover.first!
        item.specification = self.specification
        item.primePrice = self.primePrice
        return item
    }
}

