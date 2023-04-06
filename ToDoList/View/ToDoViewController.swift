//
//  ViewController.swift
//  ToDoList
//
//  Created by Fatma on 05/04/2023.
//

import UIKit

class ToDoViewController: UIViewController {

    @IBOutlet weak var todoTasksTableView: UITableView!
    {
        didSet{
            todoTasksTableView.dataSource = self
            todoTasksTableView.delegate = self
            let nib = UINib(nibName: "TaskTableViewCell", bundle: nil)
            todoTasksTableView.register(nib, forCellReuseIdentifier: "taskCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addNewTask(_ sender: Any) {
        let addNewTaskVC = self.storyboard?.instantiateViewController(withIdentifier: "add") as! AddTaskViewController
        self.navigationController?.pushViewController(addNewTaskVC, animated: true)
    }
}

extension ToDoViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
        cell.taskTitle.text = "Task Name"
        cell.taskPriorityImage.image = UIImage(named: "high")
        return cell
    }
}

extension ToDoViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}
