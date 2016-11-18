//
//  DetailViewController.swift
//  TasksAppMVC
//
//  Created by Dmitriy Melnichenko on 11/17/16.
//  Copyright © 2016 Dmitriy Melnichenko. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextViewDelegate {

    var currentTask: Task!
    
    @IBOutlet weak var textView: UITextView!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if currentTask != nil {
            textView.text = currentTask.taskDescription
        }
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.dismissKeyboard))
        self.view.addGestureRecognizer(gestureRecognizer)
        
        self.automaticallyAdjustsScrollViewInsets = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.backAction()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let line = textView.caretRect(for: (textView.selectedTextRange?.start)!)
        let overflow = line.origin.y + line.size.height - (textView.contentOffset.y + textView.bounds.size.height * 0.55 - textView.contentInset.bottom - textView.contentInset.top)
        if overflow > 0 {
            var offset = textView.contentOffset
            offset.y += overflow + 7
            textView.setContentOffset(offset, animated: false)
        }
    }
    
}

extension DetailViewController {
    func dismissKeyboard() {
        self.textView.resignFirstResponder()
    }
}


extension DetailViewController: Dismissable {
    
    func backAction() {
        let dataManager = DataManager()
        
        if currentTask != nil {
            dataManager.updateTask(task: currentTask, taskDescription: textView.text)
        } else {
            dataManager.addTask(taskDescription: textView.text)
        }
  
    }
    
}
