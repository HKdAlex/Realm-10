//
//  ViewController.swift
//  Realm 5.5.0
//
//  Created by Alex on 26.01.2021.
//

import Cocoa
import RealmSwift

class ViewController: NSViewController {
    @IBOutlet weak var dogsModifiedTextField: NSTextField!
    @IBOutlet weak var personsModifiedTextField: NSTextField!
    
    let realmManager = RealmManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realmManager.populate(with: 100_000)
        realmManager.setupTokens()
    }
    
    @IBAction func changeRandomDogName(_ sender: Any) {
        realmManager.changeRandomDogName()
    }
    
    @IBAction func changeRandomPersonName(_ sender: Any) {
        realmManager.changeRandomPersonName()
    }
    
}





