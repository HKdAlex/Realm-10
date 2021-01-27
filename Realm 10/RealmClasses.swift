//
//  RealmClasses.swift
//  Realm 5.5.0
//
//  Created by Alex on 26.01.2021.
//

import Foundation
import RealmSwift

class Person: Object {
    @objc dynamic var name = ""
    let dogs = List<Dog>()
    
    @objc dynamic var uuid: String = ""
    override static func primaryKey() -> String? {
        return "uuid"
    }
}
class Dog: Object {
    @objc dynamic var name = ""
    @objc dynamic var age: Int = 0
    let owners = LinkingObjects(fromType: Person.self, property: "dogs")
    
    @objc dynamic var uuid: String = ""
    override static func primaryKey() -> String? {
        return "uuid"
    }
    
}
