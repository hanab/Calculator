//
//  CalculatorViewController + Coredata.swift
//  Calculator
//
//  Created by Hana  Demas on 10/15/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension  CalculatorViewController {
    
    //MARK: methods
    func save(history: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "History",
                                   in: managedContext)!
        let newEntry = NSManagedObject(entity: entity, insertInto: managedContext)
        
        newEntry.setValue(history, forKeyPath: "historyEntry")
        newEntry.setValue(Date.init(), forKeyPath: "date")
        
        do {
            try managedContext.save()
            self.history.insert(newEntry, at: 0)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetch() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "History")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        fetchRequest.fetchLimit = 10
        
        do {
            history = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
