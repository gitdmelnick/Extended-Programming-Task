//
//  ModalViewController.swift
//  TasksAppMVC
//
//  Created by Dmitriy Melnichenko on 11/17/16.
//  Copyright © 2016 Dmitriy Melnichenko. All rights reserved.
//

import UIKit

protocol ModalViewControllerDelegate: class {
    
    func onDismissBlock(task: Task)
}

class ModalViewController: UIViewController {
    
    var currentTask: Task!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateCreatedLabel: UILabel!
    @IBOutlet weak var dateEditedLabel: UILabel!
    
    weak var delegate: ModalViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ModalViewController.handleTap))
        self.view.addGestureRecognizer(gestureRecognizer)
        
        titleLabel.text = "Title: \(currentTask.taskDescription.components(separatedBy: "\n").first!)"
        dateCreatedLabel.text = "Created: \(currentTask.dateCreated)"
        dateEditedLabel.text = "Edited: \(currentTask.dateEdited)"
    }
    
    @IBAction func editAction(_ sender: AnyObject) {
        presentDetailViewForEditing()
    }
    
    @IBAction func deleteAction(_ sender: AnyObject) {
        let dataManager = DataManager()
        dataManager.deleteTask(task: currentTask)
        dismiss(completion: nil)
    }
    
}

extension ModalViewController {
    
    func setupView(with task: Task) {
        self.currentTask = task
    }
    
    func handleTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension ModalViewController: Dismissable {

    func presentDetailViewForEditing() {
        self.dismiss(completion: {
            self.delegate?.onDismissBlock(task: self.currentTask)
        })
    }
}

