//
//  XFSQLiteDataSource.swift
//  XFruits
//
//  Created by tangkunyin on 19/06/2017.
//  Copyright © 2017 www.10fruits.net. All rights reserved.
//

import Foundation
import SQLite

enum DataAccessError: Error {
    case Datastore_Connection_Error
    case Insert_Error
    case Delete_Error
    case Update_Error
    case Search_Error
    case Nil_In_Data
}

protocol DataHelperProtocol {
    associatedtype T
    static func createTable() throws -> Void
    static func insert(item: T) throws -> Bool
    static func update(item: T) throws -> Bool
    static func find(gid: String?) throws -> T?
    static func findAll() throws -> [T]
    static func delete(gid: String?) throws -> Bool
    static func deleteAll() throws -> Bool
}

class XFSQLiteDataSource {
    
    static let sharedInstance = XFSQLiteDataSource()
    
    let Db:Connection?

    private init(){
        let path:String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        do {
            let dbFilePath = "\(path)/XFruits.sqlite3"
            dPrint("dbFilePath is: \(dbFilePath)")
            Db = try Connection(dbFilePath)
            // Thread-Safety
            Db?.busyHandler({ (tries) -> Bool in
                if tries >= 3 {
                    return false
                }
                return true
            })
        } catch let error as NSError {
            Db = nil
            dPrint(error.localizedDescription)
        }
    }
    
    func createTables() {
        do {
            try XFCartDataHelper.createTable()
        } catch let error as NSError {
            dPrint(error.localizedDescription)
        }
    }

}
