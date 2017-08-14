//
//  XFPayResponse.swift
//  XFruits
//
//  Created by tangkunyin on 2017/8/14.
//  Copyright © 2017年 www.10fruits.net. All rights reserved.
//

import Foundation
import HandyJSON


/// https://doc.open.alipay.com/doc2/detail.htm?treeId=204&articleId=105302&docType=1
struct XFAlipayTradeResponse: HandyJSON {
    var code: String = ""
    var msg: String = ""
    var app_id: String = ""
    var auth_app_id: String = ""
    var charset: String = ""
    var timestamp: String = ""
    var total_amount: String = ""
    var trade_no: String = ""
    var seller_id: String = ""
    var out_trade_no: String = ""
}
struct XFAlipayResultData: HandyJSON {
    var alipay_trade_app_pay_response: XFAlipayTradeResponse?
    var sign: String = ""
    var sign_type: String = ""
}
// 支付宝支返回的数据模型
struct XFAlipayResponse: HandyJSON {
    var memo: String = ""
    var result: XFAlipayResultData?
    var resultStatus: Int = 0
}
