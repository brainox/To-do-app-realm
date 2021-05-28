//
//  Model.swift
//  ToDo_Realm
//
//  Created by Decagon on 25/05/2021.
//

import Foundation
import RealmSwift

class TodoListItem: Object {
    @objc dynamic var  item: String = ""
    @objc dynamic var date: Date = Date()
}
