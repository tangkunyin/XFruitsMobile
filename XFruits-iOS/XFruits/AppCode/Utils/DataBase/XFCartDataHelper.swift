//
//  XFCartDataHelper.swift
//  XFruits
//
//  Created by tangkunyin on 19/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import Foundation
import SQLite


typealias XFCart = (
    index:Int64?,
    id:String?,
    name:String?,
    desc:String?,
    cover:String?,
    primePrice:Double?,
    quantity:Int64?,
    selected:Bool?,
    status:Int64?
)

class XFCartDataHelper: DataHelperProtocol {
    
    typealias T = XFCart
    
    static let TABLE_NAME = "XF_ShopCart"
    static let table = Table(TABLE_NAME)
    
    static let index = Expression<Int64>("index")//自增索引
    static let id = Expression<String>("id")
    static let name = Expression<String>("name")
    static let desc = Expression<String>("desc")
    static let cover = Expression<String>("cover")
    static let primePrice = Expression<Double>("primePrice")
    static let quantity = Expression<Int64>("quantity")
    static let selected = Expression<Bool>("selected")
    static let status = Expression<Int64>("status")//默认状态是0，1表示已删除（不是真删除数据）
    
    static func createTable() throws {
        guard let DB = XFSQLiteDataSource.sharedInstance.Db else {
            throw DataAccessError.Datastore_Connection_Error
        }
        do {
            try DB.run( table.create(ifNotExists: true) {t in
                t.column(index, primaryKey: .autoincrement)
                t.column(id, unique:true)
                t.column(name)
                t.column(desc)
                t.column(cover)
                t.column(primePrice)
                t.column(quantity, defaultValue:1)
                t.column(selected, defaultValue:true)
                t.column(status, defaultValue:0)
            })
        } catch let error as NSError {
            dPrint(error.localizedDescription)
        }
    }
    
    static func insert(item: T) throws -> Bool {
        guard let DB = XFSQLiteDataSource.sharedInstance.Db else {
            throw DataAccessError.Datastore_Connection_Error
        }
        if let gid = item.id,
            let gname = item.name,
            let gdesc = item.desc,
            let gcover = item.cover,
            let gprimePrice = item.primePrice {
            let insert = table.insert(id <- gid,
                                      name <- gname,
                                      desc <- gdesc,
                                      cover <- gcover,
                                      primePrice <- gprimePrice,
                                      quantity <- 1)
            do {
                let rowId = try DB.run(insert)
                guard rowId > 0 else {
                    return false
                }
                return true
            } catch let error as NSError {
                dPrint(error.localizedDescription)
            }
        }
        throw DataAccessError.Nil_In_Data
    }
    
    static func update(item: T) throws -> Bool {
        guard let DB = XFSQLiteDataSource.sharedInstance.Db, let gid = item.id else {
            throw DataAccessError.Nil_In_Data
        }
        do {
            let query = table.filter(id == gid)
            var updateSetter = [Setter]()
            // 按条件更新
            if let newQuantity = item.quantity {
                updateSetter.append(quantity <- newQuantity)
            }
            if let newSelected = item.selected {
                updateSetter.append(selected <- newSelected)
            }
            if let newStatus = item.status {
                updateSetter.append(status <- newStatus)
            }
            let tmp = try DB.run(query.update(updateSetter))
            guard tmp == 1 else {
                return false
            }
            return true
        } catch let error as NSError {
            dPrint(error.localizedDescription)
            return false
        }
    }
    
    static func find(gid: String?) throws -> T? {
        guard let gid = gid else {
            return nil
        }
        guard let DB = XFSQLiteDataSource.sharedInstance.Db else {
            throw DataAccessError.Datastore_Connection_Error
        }
        do {
            let query = table.filter(id == gid)
            let items = try DB.prepare(query)
            for item in items {
                return XFCart(index:item[index],
                              id:item[id],
                              name:item[name],
                              desc:item[desc],
                              cover:item[cover],
                              primePrice:item[primePrice],
                              quantity:item[quantity],
                              selected:item[selected],
                              status:item[status])
            }
        } catch let error as NSError {
            dPrint(error.localizedDescription)
        }
        return nil
    }
    
    static func findAll() throws -> [T] {
        guard let DB = XFSQLiteDataSource.sharedInstance.Db else {
            throw DataAccessError.Datastore_Connection_Error
        }
        var retArray = [T]()
        do {
            let items = try DB.prepare(table)
            for item in items {
                retArray.append(XFCart(index:item[index],
                                       id:item[id],
                                       name:item[name],
                                       desc:item[desc],
                                       cover:item[cover],
                                       primePrice:item[primePrice],
                                       quantity:item[quantity],
                                       selected:item[selected],
                                       status:item[status]))
            }
        } catch let error as NSError {
            dPrint(error.localizedDescription)
        }
        return retArray
    }

    static func delete(gid: String?) throws -> Bool {
        guard let gid = gid else {
            return false
        }
        guard let DB = XFSQLiteDataSource.sharedInstance.Db else {
            throw DataAccessError.Datastore_Connection_Error
        }
        let query = table.filter(id == gid)
        do {
            let tmp = try DB.run(query.delete())
            guard tmp == 1 else {
                return false
            }
            return true
        } catch let error as NSError {
            dPrint(error.localizedDescription)
            return false
        }
    }
    
    static func deleteAll() throws -> Bool {
        guard let DB = XFSQLiteDataSource.sharedInstance.Db else {
            throw DataAccessError.Datastore_Connection_Error
        }
        do {
            let tmp = try DB.run(table.delete())
            guard tmp == 1 else {
                return false
            }
            return true
        } catch let error as NSError {
            dPrint(error.localizedDescription)
            return false
        }
    }
    
}
