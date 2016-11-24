//
//  DatabaseHelper.swift
//  chrisras-pset4
//
//  Created by Christopher Ras on 24/11/2016.
//  Copyright © 2016 Chris Ras. All rights reserved.
//

import Foundation
import SQLite

class DatabaseHelper {
    
    private let tasks = Table("tasks")
    private let id = Expression<Int64>("id")
    private let entry = Expression<String?>("entry")
    private var db: Connection?
    
    init?() {
        do {
            try setupDatabase()
        } catch {
            print(error)
            return nil
        }
    }
    
    private func setupDatabase() throws {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        do {
            db = try Connection("\(path)/db.sqlite3")
            try createTable()
        } catch {
            throw error
        }
    }
    
    private func createTable() throws {
        do {
            try db!.run(tasks.create(ifNotExists: true) {
                t in
                
                t.column(id, primaryKey: .autoincrement)
                t.column(entry, unique: true)
            })
        } catch {
            throw error
        }
    }
    
    func addToDB(entry: String) throws {
        let insert = tasks.insert(self.entry <- entry)
        do {
            try db!.run(insert)
        } catch {
            throw error
        }
    }
    
    func readFromDB() throws -> Array<String> {
        var currentTasks = [String]()
        do {
            for task in try db!.prepare(tasks) {
                currentTasks.append(task[entry]!)
            }
            
            return currentTasks
            
        } catch {
            throw error
        }
    }
    
    func deleteFromDB(task: String) throws {
        let toBeDeleted = tasks.filter(entry == task)
        do {
            if try db!.run(toBeDeleted.delete()) > 0 {
                print("\(task) deleted")
            } else {
                print("\(task) not found")
            }
            
        } catch {
            print(error)
        }
        
    }
}
