//
//  DataManager.swift
//  TasksAppMVC
//
//  Created by Dmitriy Melnichenko on 11/17/16.
//  Copyright © 2016 Dmitriy Melnichenko. All rights reserved.
//

import RealmSwift

protocol DataManagerDelegate: class {
    func didFinishRetrieval(tasks: [Task])
}

final class DataManager {
    
    weak var delegate: DataManagerDelegate?
    
    var realm: Realm!
    var notificationToken: NotificationToken!
    
    func retrieveTasks() {
        self.realm = try! Realm()
        
        func updateList() {
            let tasks = Array(realm.objects(Task.self))
            self.delegate?.didFinishRetrieval(tasks: tasks)
        }
        
        updateList()
        
        self.notificationToken = self.realm.addNotificationBlock({_,_ in
            updateList()
        })
    }
    
    func addTask(taskDescription: String) {
        self.realm = try! Realm()
        
        try! realm.write {
            if realm.isEmpty {
                realm.add(Task(value: [0, taskDescription, Date().string(format: "MM/dd/yyyy HH:mm"), ""]))
            } else {
                let id = realm.objects(Task.self).max(ofProperty: "id")! + 1
                realm.add(Task(value: [id, taskDescription, Date().string(format: "MM/dd/yyyy HH:mm"), ""]))
            }
        }
    }
    
    func deleteTask(task: Task) {
        self.realm = try! Realm()
        
        try! realm.write {
            realm.delete(task)
        }
    }
    
    func updateTask(task: Task, taskDescription: String) {
        self.realm = try! Realm()
        
        try! realm.write {
            task.taskDescription = taskDescription
            task.dateEdited = Date().string(format: "MM/dd/yyyy HH:mm")
            realm.add(task, update: true)
        }
    }
    
}

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
}

extension String {
    func date(format: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.date(from: self)!
    }
}
