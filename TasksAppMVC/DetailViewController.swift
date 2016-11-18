//
//  DetailViewController.swift
//  TasksAppMVC
//
//  Created by Dmitriy Melnichenko on 11/17/16.
//  Copyright © 2016 Dmitriy Melnichenko. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController, UITextViewDelegate {

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
        
        self.addToolBarToInput()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.backAction()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let line = textView.caretRect(for: (textView.selectedTextRange?.start)!)
        let overflow = line.origin.y + line.size.height - (textView.contentOffset.y + textView.bounds.size.height * 0.5 - textView.contentInset.bottom - textView.contentInset.top)
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
    
    func backAction() {
        let dataManager = DataManager()
        
        if currentTask != nil {
            dataManager.updateTask(task: currentTask, taskDescription: textView.text)
        } else {
            dataManager.addTask(taskDescription: textView.text)
        }
        
    }
    
    func addToolBarToInput() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        toolbar.barStyle = UIBarStyle.default
        toolbar.tintColor = UIColor.white
        toolbar.barTintColor = UIColor.blue
        toolbar.items = [
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(DetailViewController.dismissKeyboard))
        ]
        textView.inputAccessoryView = toolbar
    }
}

