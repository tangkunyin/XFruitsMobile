//
//  XFOrder.swift
//  XFruits
//
//  Created by tangkunyin on 2017/8/19.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import Foundation
import HandyJSON

struct XFOrderProduct: HandyJSON {
    var id:String = ""
    var name:String = ""
    var cover:String = ""
    var specification:String = ""
    var primePrice:Float = 0
    var sellStatus:Int?
    var platform:Int?
    var unit:Int?
    var quantity:Int?
    var delete:Bool?
    var buyCount:Int = 0
}

struct XFOrderContent: HandyJSON {
    var orderId: String = ""
    var productList: Array<XFOrderProduct>?
    var cashFee: Float = 0
    var status: Int = 0
    var orderExpiration: Int = 0
}

struct XFOrderDetailProduct: HandyJSON {
    var id: Int = 0
    var name: String = ""
    var description: String = ""
    var cover: String = ""
    var specification: String?
    var type: Int = 0
    var primePrice: Float = 0
    var service: String = ""
    var priority: Int = 0
    var sellStatus: Int?
    var platform: Int?
    var unit: String = ""
    var quantity: Int?
    var delete: Bool = false
    var createAt: Int = 0
    var updateAt: Int = 0
}

struct XFOrderGoodsItem: HandyJSON {
    var product: XFOrderDetailProduct?
    var count: Int = 0
}


// ===================================================

struct XFOrder: HandyJSON {
    var page: Int = 0
    var size: Int = 0
    var totalElements: Int = 0
    var totalPages: Int = 0
    var content: Array<XFOrderContent>?
}

struct XFOrderDetail: HandyJSON {
    var orderId: String = ""
    var cashFee: Float = 0
    var expressFee: Float = 0
    var payType: Int = 0
    var createAt: Int = 0
    var status: Int = 0
    var address: XFAddress?
    var productBuyList: Array<XFOrderGoodsItem>?
}

