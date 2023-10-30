//
//  LocalStorageManager.swift
//  SQLiteTest
//
//  Created by Naw Su Su Nyein on 29/10/2023.
//

import Foundation
import SQLite3

let FILE_NAME = "localdb.sqlite"

class LocalStorageManager {
    var db  : OpaquePointer?
    var stmt : OpaquePointer?
    init() {
        //create fileurl
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(FILE_NAME)
        print("file url : \(fileURL)")
        //opening the database
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error opening database")
        }
    }
    
    func createTable(queryString : String) {
        if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Table Created")
            } else {
                let errorMsg = String(cString: sqlite3_errmsg(db))
                print("Table can't be created : \(errorMsg)")
            }
        } else {
            let errorMsg = String(cString: sqlite3_errmsg(db))
            print("Statment can't be prepared : \(errorMsg)")
        }
        sqlite3_finalize(stmt)
    }
    
    func insert(blogList : [Blog],queryString : String, completionError : (String) -> Void, readyInsertion : (Bool) -> Void) {
        for blog in blogList {
            if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) != SQLITE_OK {
                let errorMsg = String(cString: sqlite3_errmsg(db))
                sqlite3_finalize(stmt)
                completionError(errorMsg)
            } else {
                //readyInsertion(true)
                let title = blog.title as? NSString
                let contents = blog.contents as? NSString
                
                if(sqlite3_bind_text(stmt, 1, title?.utf8String , -1, nil) != SQLITE_OK) {
                    let errorMsg = String(cString: sqlite3_errmsg(db))
                    sqlite3_finalize(stmt)
                    completionError(errorMsg)
                }
                
                if(sqlite3_bind_text(stmt, 2, contents?.utf8String , -1, nil) != SQLITE_OK) {
                    let errorMsg = String(cString: sqlite3_errmsg(db))
                    sqlite3_finalize(stmt)
                    completionError(errorMsg)
                }
                
                if(sqlite3_bind_int(stmt, 3, blog.price) != SQLITE_OK) {
                    let errorMsg = String(cString: sqlite3_errmsg(db))
                    sqlite3_finalize(stmt)
                    completionError(errorMsg)
                }
                
                if(sqlite3_step(stmt) == SQLITE_DONE) {
                    readyInsertion(true)
                } else {
                    let errorMsg = String(cString: sqlite3_errmsg(db))
                    completionError(errorMsg)
                }
            }
        }
       
    }
    
    func getData(queryString : String?, completion : ([Any]?) -> Void, completionError : (String?) -> Void) {
        var dataList : [Any] = []
        if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            completionError(errorMessage)
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let title = String(cString: sqlite3_column_text(stmt, 0))
            dataList.append(title)
        }
        
        sqlite3_finalize(stmt)
        completion(dataList)
    }
    
    func deleteData(queryString : String, completion : (Bool) -> Void, completionError : (String) -> Void) {
        if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            completionError(errmsg)
            print(" Error preparing to delete : \(errmsg)")
        }
        
        if sqlite3_step(stmt) == SQLITE_DONE{
            print(" Successfully deleted row .")
        }else{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            completionError(errmsg)
            print("Could not delte row : \(errmsg)")
        }
        sqlite3_finalize(stmt)
        completion(true)
    }
    
    func updateData(queryString : String, completion : (Bool) -> Void, completionError : (String) -> Void) {
        if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            completionError(errorMessage)
        }
        if sqlite3_step(stmt) == SQLITE_DONE {
            print("successfully updated row")
        } else {
            let errMessage = String(cString: sqlite3_errmsg(db))
            print("Counld not update row : \(errMessage)")
            completionError(errMessage)
        }
        sqlite3_finalize(stmt)
        completion(true)
    }
}
