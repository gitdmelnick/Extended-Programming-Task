//
//  TaskViewCell.swift
//  TasksAppMVC
//
//  Created by Dmitriy Melnichenko on 11/17/16.
//  Copyright © 2016 Dmitriy Melnichenko. All rights reserved.
//

import UIKit

final class TaskViewCell: UITableViewCell {
    
    func configure(with task: Task) {
        let title = task.taskDescription.components(separatedBy: "\n").first!
        textLabel?.text = title
    }
}
