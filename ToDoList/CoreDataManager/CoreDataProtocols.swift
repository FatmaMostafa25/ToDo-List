//
//  CoreDataProtocols.swift
//  ToDoList
//
//  Created by Fatma on 06/04/2023.
//

import Foundation
import CoreData

protocol CartCD {
    func saveTask(newTask : Tasks)
    func fetchTasks(state : Int)-> [NSManagedObject]?
    func editTask(editedTask : Tasks)
    func deleteTask(id : UUID, taskState : Int)
}
