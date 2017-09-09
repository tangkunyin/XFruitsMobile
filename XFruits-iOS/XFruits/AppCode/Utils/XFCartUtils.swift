//
//  XFCartUtils.swift
//  XFruits
//
//  Created by tangkunyin on 25/05/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import Foundation

/// 果篮专用工具类
class XFCartUtils {
    
    static let sharedInstance = XFCartUtils()
    
    fileprivate init(){
        XFSQLiteDataSource.sharedInstance.createTables()
    }
    
    /// 已选的数据集
    var selectedList: Array<XFCart?> = []
    
    
    func getAll() -> Array<XFCart?> {
        var dataList:Array<XFCart?> = []
        do {
            let result =  try XFCartDataHelper.findAll()
            if selectedList.count > 0 {
                selectedList.removeAll()
            }
            for cart:XFCart in result {
                if let status = cart.status, status == 0 {
                    dataList.append(cart)
                }
                if let selected = cart.selected, selected == true {
                    selectedList.append(cart)
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
                                   quantity: Int64(1),
                                   selected: false,
                                   status: 0)
            if nil == obj {
                return try XFCartDataHelper.insert(item: paramCart)
            } else {
                if obj?.status! == 0 {
                    paramCart.quantity = (obj?.quantity)! + 1
                }
                return try XFCartDataHelper.update(item: paramCart)
            }
        } catch let error as NSError {
            dPrint(error.localizedDescription)
            return false
        }
    }
    
    
    func deleteItem(gid: String?) ->Bool {
        do {
            if let gid = gid {
                return try XFCartDataHelper.delete(gid: gid)
            }
            return false
        } catch let error as NSError {
            dPrint(error.localizedDescription)
            return false
        }
    }
    
    func deleteAllCart() -> Bool {
        do {
            return try XFCartDataHelper.deleteAll()
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
                                   quantity: nil,
                                   selected: checked,
                                   status: nil)
            return try XFCartDataHelper.update(item: paramCart)
        } catch let error as NSError {
            dPrint(error.localizedDescription)
            return false
        }
    }

    
    func changeCount(gid:String, count:Int) -> Bool{
        do {
            let paramCart = XFCart(index: nil,
                                   id: gid,
                                   name: nil,
                                   desc: nil,
                                   cover: nil,
                                   primePrice: nil,
                                   quantity: Int64(count),
                                   selected: nil,
                                   status: nil)
            return try XFCartDataHelper.update(item: paramCart)
        } catch let error as NSError {
            dPrint(error.localizedDescription)
            return false
        }
    }
    
    
    /// 完成下单后清除已选择的商品
    func clearSelected(carts: Array<XFCart>) -> Bool {
        var flag = false
        for item: XFCart in carts {
            if let gid = item.id {
                flag = deleteItem(gid: gid)
            }
        }
        return flag
    }
    
}
