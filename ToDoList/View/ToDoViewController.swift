//
//  ViewController.swift
//  ToDoList
//
//  Created by Fatma on 05/04/2023.
//

import UIKit
import CoreData

class ToDoViewController: UIViewController {

    var todoTasksList : [NSManagedObject]?
    var coreDataViewModel : CoreDataViewModel?

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
        coreDataViewModel = CoreDataViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        todoTasksList = coreDataViewModel?.tasksDataBase.fetchTasks(state: 1)
        todoTasksTableView.reloadData()
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
        return todoTasksList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
        cell.taskTitle.text = todoTasksList?[indexPath.row].value(forKey: "title") as? String
        switch todoTasksList?[indexPath.row].value(forKey: "priority") as? Int
        {
        case 1 :
            cell.taskPriorityImage.image = UIImage(named: "high")
        case 2 :
            cell.taskPriorityImage.image = UIImage(named: "med")
        case 3 :
            cell.taskPriorityImage.image = UIImage(named: "low")
        default :
            cell.taskPriorityImage.image = UIImage(named: "high")
        }
        return cell
    }
}

extension ToDoViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editTaskVC = storyboard?.instantiateViewController(withIdentifier: "editTask")
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            let deleteAlert : UIAlertController  = UIAlertController(title:"Delete this product?", message:"Are you sure you want to delete this product from cart ?", preferredStyle: .actionSheet)
            deleteAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ [self] action in
                self.coreDataViewModel?.tasksDataBase.deleteTask(id: todoTasksList?[indexPath.row].value(forKey: "id") as! UUID)
                self.todoTasksList?.remove(at: indexPath.row)
                self.todoTasksTableView.reloadData()
            }))
            deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(deleteAlert, animated:true, completion:nil )
    }
    
}
