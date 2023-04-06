//
//  CoreDataManager.swift
//  ToDoList
//
//  Created by Fatma on 06/04/2023.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager : CartCD {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let managedContext : NSManagedObjectContext!
    let entity : NSEntityDescription!
    
    private static var cartInstance : CoreDataManager?
    
    public static func getCartInstance() -> CoreDataManager {
        if let instance = cartInstance {
            return instance
        }else{
            cartInstance = CoreDataManager()
            return cartInstance!
        }
    }
    
    private init () {
        managedContext = appDelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "SavedTask", in: managedContext)
    }
    
    func saveTask(newTask : Tasks) {
        let task = NSEntityDescription.insertNewObject(forEntityName: "SavedTask", into: managedContext)
        task.setValue(UUID(), forKey: "id")
        task.setValue(newTask.title, forKey: "title")
        task.setValue(newTask.descriptions, forKey: "descriptions")
        task.setValue(newTask.priority, forKey: "priority")
        task.setValue(newTask.state, forKey: "state")
        task.setValue(newTask.date, forKey: "date")
        print("saved!!!")
        try?self.managedContext.save()
    }
    
    func fetchTasks(state : Int) -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SavedTask")
        let pred = NSPredicate(format: "state == %i", state as CVarArg )
        fetchRequest.predicate = pred
        if let arr = try? managedContext.fetch(fetchRequest) {
            if arr.count > 0 {
                return arr
            }
            return nil
        }else{
            return nil
        }
    }
    
    func deleteTask(id : UUID) {
        if let arr = fetchTasks(state: 1) {
            for obj in arr {
                if obj.value(forKey:"id") as! UUID == id {
                    managedContext.delete(obj)
                    try?managedContext.save()
                }
            }
        }
    }
 
}

