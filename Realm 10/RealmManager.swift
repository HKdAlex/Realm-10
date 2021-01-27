//
//  RealmManager.swift
//  Realm 5.5.0
//
//  Created by Alex on 26.01.2021.
//

import Foundation
import RealmSwift

class RealmManager {
    
    var dogsToken: NotificationToken?
    var personsToken: NotificationToken?
    
    func setupTokens() {
        
        let realm = try! Realm()
        
        personsToken = realm.objects(Person.self).observe { changes in
            
            switch changes {
            case .initial:
                print("initial persons")
            case .update(let objects, deletions: _, insertions: _, modifications: let modifications):
                print("\(modifications.count) person(s) modified")
                modifications.forEach { print("person \(objects[$0].name) that has\t\(objects[$0].dogs.count)\tdogs modified") }
            case .error:
                fatalError()
            }
        }
        
        dogsToken = realm.objects(Dog.self).observe { changes in
            switch changes {
            case .initial:
                print("initial dogs")
            case .update(let objects, deletions: _, insertions: _, modifications: let modifications):
                print("\(modifications.count) dog(s) modified")
                modifications.forEach { print("dog \(objects[$0].name) modified") }
            case .error:
                fatalError()
            }
        }
    }
    
    func populate(with itemCount: Int) {
        let realm = try! Realm()
        
        if realm.objects(Person.self).isEmpty || realm.objects(Dog.self).isEmpty {
            
            realm.beginWrite()
            
            realm.deleteAll()
            
            for _ in 0..<itemCount {
                autoreleasepool {
                    let dog = Dog()
                    dog.uuid = UUID().uuidString
                    dog.name = randomName(length: 16)
                    dog.age = .random(in: 1...128)
                    realm.add(dog)
                }
            }
            try! realm.commitWrite()
            
            let dogs = realm.objects(Dog.self)
            
            realm.beginWrite()
            
            for _ in 0..<itemCount {
                autoreleasepool {
                    let person = Person()
                    person.uuid = UUID().uuidString
                    person.name = randomName(length: 16)
                    
                    let dogs = (0...Int.random(in: 0...50))
                        .map { _ in
                            Int.random(in: 0..<itemCount)
                        }
                        .map { dogs[$0] }
                    
                    person.dogs.append(objectsIn: dogs)
                    realm.add(person)
                }
            }
            try! realm.commitWrite()
        }
    }
    
    func changeRandomDogName() {
        let realm = try! Realm()
        let dogs = realm.objects(Dog.self)
        let randomDog = dogs[Int.random(in: 0..<dogs.count)]
        try! realm.write {
            randomDog.name = randomName(length: 16)
        }
    }
    
    func changeRandomPersonName() {
        let realm = try! Realm()
        let persons = realm.objects(Person.self)
        let randomPerson = persons[Int.random(in: 0..<persons.count)]
        try! realm.write {
            randomPerson.name = randomName(length: 16)
        }
    }
}
