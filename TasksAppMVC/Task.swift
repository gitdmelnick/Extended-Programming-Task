//
//  Task.swift
//  TasksApp
//
//  Created by Dmitriy Melnichenko on 11/11/16.
//  Copyright © 2016 Dmitriy Melnichenko. All rights reserved.
//

import RealmSwift

final class Task: Object {
    
    dynamic var id = 0
    dynamic var taskDescription = ""
    dynamic var dateCreated = ""
    dynamic var dateEdited = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
