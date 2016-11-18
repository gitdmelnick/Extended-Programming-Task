//
//  DetailViewController.swift
//  TasksAppMVC
//
//  Created by Dmitriy Melnichenko on 11/17/16.
//  Copyright © 2016 Dmitriy Melnichenko. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var currentTask: Task!
    
    @IBOutlet weak var textView: UITextView!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if currentTask != nil {
            textView.text = currentTask.taskDescription
        }
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(DetailViewController.backAction))   
    }
}

extension DetailViewController: Dismissable {
    
    func backAction() {
        let dataManager = DataManager()
        
        if currentTask != nil {
            dataManager.updateTask(task: currentTask, taskDescription: textView.text)
            self.dismiss(completion: nil)
        } else {
            dataManager.addTask(taskDescription: textView.text)
            self.dismiss(completion: nil)
        }
  
    }
    
}
