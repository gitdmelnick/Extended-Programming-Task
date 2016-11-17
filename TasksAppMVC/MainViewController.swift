//
//  ViewController.swift
//  TasksAppMVC
//
//  Created by Dmitriy Melnichenko on 11/17/16.
//  Copyright © 2016 Dmitriy Melnichenko. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var tasks = [Task]()
    
    let dataManager = DataManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(TaskViewCell.self, forCellReuseIdentifier: "TaskViewCell")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(MainViewController.presentDetailView))
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        dataManager.delegate = self
        dataManager.retrieveTasks()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension MainViewController: ModalViewControllerDelegate {
    
    func onDismissBlock(task: Task) {
        presentDetailViewForEditing(with: task)
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentModalView(with: tasks[indexPath.row])
    }
    
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskViewCell", for: indexPath) as! TaskViewCell
        cell.configure(with: tasks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
}

extension MainViewController: DataManagerDelegate {
    
    func didFinishRetrieval(tasks: [Task]) {
        self.tasks = tasks
        
        tableView.reloadData()
        
        tableView.indexPathsForSelectedRows?.forEach {
            tableView.deselectRow(at: $0, animated: true)
        }
    }
    
}

extension MainViewController: Presentable {
    
    func presentDetailView() {
        let viewController = storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        self.present(viewController: viewController)
    }
    
    func presentDetailViewForEditing(with task:Task) {
        let viewController = storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        viewController.currentTask = task
        self.present(viewController: viewController)
    }
    
    func presentModalView(with task: Task) {
        let viewController = storyboard!.instantiateViewController(withIdentifier: "ModalViewController") as! ModalViewController
        viewController.modalPresentationStyle = .overCurrentContext
        
        viewController.delegate = self
        viewController.setupView(with: task)
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    
}
