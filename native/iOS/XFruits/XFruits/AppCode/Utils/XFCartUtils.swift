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

    func selectItem(gid:String, checked:Bool){
        do {
            let paramCart = XFCart(index: nil,
                                   id: gid,
                                   name: nil,
                                   cover: nil,
                                   primePrice: nil,
                                   salesPrice: nil,
                                   quantity: nil,
                                   selected: checked,
                                   status: nil)
            try XFCartDataHelper.update(item: paramCart)
        } catch let error as NSError {
            dPrint(error.localizedDescription)
        }
    }
    
    
    func changeCount(gid:String, count:Int){
        do {
            let paramCart = XFCart(index: nil,
                                   id: gid,
                                   name: nil,
                                   cover: nil,
                                   primePrice: nil,
                                   salesPrice: nil,
                                   quantity: Int64(count),
                                   selected: nil,
                                   status: nil)
            try XFCartDataHelper.update(item: paramCart)
        } catch let error as NSError {
            dPrint(error.localizedDescription)
        }
    }
    
    func addItem(item: ProductItem){
        do {
            let paramCart = XFCart(index: nil,
                                   id: String(item.id),
                                   name: item.name,
                                   cover: item.cover,
                                   primePrice: Double(item.primePrice),
                                   salesPrice: Double(item.salesPrice),
                                   quantity: Int64(0),
                                   selected: false,
                                   status: 0)
            try XFCartDataHelper.update(item: paramCart)
        } catch let error as NSError {
            dPrint(error.localizedDescription)
        }
    }
    
    func deleteItem(gid: String?){
        do {
            if let gid = gid {
                try XFCartDataHelper.delete(gid: gid)
            } else {
                try XFCartDataHelper.deleteAll()
            }
        } catch let error as NSError {
            dPrint(error.localizedDescription)
        }
    }

}
