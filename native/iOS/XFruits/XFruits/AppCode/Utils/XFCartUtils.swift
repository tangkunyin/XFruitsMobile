//
//  XFCartUtils.swift
//  XFruits
//
//  Created by tangkunyin on 25/05/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import Foundation
import MBProgressHUD

// 果篮专用工具类
struct XFCartUtils {
    
    static let sharedInstance = XFCartUtils()
    
    private init(){
        XFSQLiteDataSource.sharedInstance.createTables()
    }
    
    func getAll() -> Array<XFCart?> {
        var dataList:Array<XFCart?> = []
        do {
            let result =  try XFCartDataHelper.findAll()
            for cart:XFCart in result {
                if let status = cart.status, status == 0 {
                    dataList.append(cart)
                }
            }
            return dataList
        } catch let error as NSError {
            dPrint(error.localizedDescription)
        }
        return dataList
    }

    func addItem(item: ProductItem) -> Bool {
        do {
            let obj = try XFCartDataHelper.find(gid: item.id)
            var paramCart = XFCart(index: nil,
                                   id: item.id,
                                   name: item.name,
                                   desc: item.specification,
                                   cover: item.cover,
                                   primePrice: Double(item.primePrice),
                                   salesPrice: Double(item.salesPrice),
                                   quantity: Int64(0),
                                   selected: false,
                                   status: 0)
            var result: Bool?
            if nil == obj {
                result = try XFCartDataHelper.insert(item: paramCart)
            } else {
                paramCart.quantity = (obj?.quantity)! + 1
                result = try XFCartDataHelper.update(item: paramCart)
            }
            if let result = result {
                return result
            }
            return false
        } catch let error as NSError {
            dPrint(error.localizedDescription)
            return false
        }
    }
    
    
    func deleteItem(gid: String?) ->Bool {
        do {
            if let gid = gid {
                let reuslt = try XFCartDataHelper.delete(gid: gid)
                return reuslt
            }
            return false
        } catch let error as NSError {
            dPrint(error.localizedDescription)
            return false
        }
    }
    
    func deleteAllCart() -> Bool {
        do {
            let reuslt = try XFCartDataHelper.deleteAll()
            return reuslt
        } catch let error as NSError {
            dPrint(error.localizedDescription)
            return false
        }
    }
    
    func selectItem(gid:String?, checked:Bool) -> Bool {
        do {
            let paramCart = XFCart(index: nil,
                                   id: gid,
                                   name: nil,
                                   desc: nil,
                                   cover: nil,
                                   primePrice: nil,
                                   salesPrice: nil,
                                   quantity: nil,
                                   selected: checked,
                                   status: nil)
            let result = try XFCartDataHelper.update(item: paramCart)
            return result
        } catch let error as NSError {
            dPrint(error.localizedDescription)
            return false
        }
    }

    
//    func changeCount(gid:String, count:Int){
//        do {
//            let paramCart = XFCart(index: nil,
//                                   id: gid,
//                                   name: nil,
//                                   cover: nil,
//                                   primePrice: nil,
//                                   salesPrice: nil,
//                                   quantity: Int64(count),
//                                   selected: nil,
//                                   status: nil)
//            try XFCartDataHelper.update(item: paramCart)
//        } catch let error as NSError {
//            dPrint(error.localizedDescription)
//        }
//    }
//    
//    
//    


}
