//
//  RealmServices.swift
//  ToDo_Realm
//
//  Created by Decagon on 27/05/2021.
//

import RealmSwift
import Foundation

class RealmService {
    static let shared = RealmService()
    var realm = try! Realm()
    
    func create<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print(error)
        }
    }
    
    func updateTask(_ newTask: String, category: TodoListItem) {
        do {
            try realm.write {
                category.item = newTask
                realm.add(category)
            }
        } catch {
            print(error)
        }
    }
    
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
                try! realm.commitWrite()
            }
        } catch {
            print(error)
        }
    }
    
}
