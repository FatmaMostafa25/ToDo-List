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
    let dateFormatter : DateFormatter = DateFormatter()
    var d : Date?
    var date : String = " "
    var colors : [String] = ["A","B","C","D"]
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
        dateFormatter.dateStyle = .long
    }
    override func viewWillAppear(_ animated: Bool) {
        todoTasksList = coreDataViewModel?.tasksDataBase.fetchTasks(state: 1)
        todoTasksTableView.reloadData()
    }
    
    @IBAction func searchForTask(_ sender: Any) {
        let searchVC = storyboard?.instantiateViewController(withIdentifier: "Search") as! SearchViewController
        navigationController?.pushViewController(searchVC, animated: true)
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
        d = todoTasksList?[indexPath.row].value(forKey: "date") as? Date
    //    date = dateFormatter.string(from: d!)
    //   cell.taskDate.text = date
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
        //cell.backgroundColor = UIColor(named: colors[indexPath.row])
        return cell
    }
}

extension ToDoViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editTaskVC = storyboard?.instantiateViewController(withIdentifier: "editTask") as! EditTaskViewController
        editTaskVC.editedTask.id = todoTasksList?[indexPath.row].value(forKey: "id") as? UUID
        editTaskVC.editedTask.title = todoTasksList?[indexPath.row].value(forKey: "title") as? String
        editTaskVC.editedTask.descriptions = todoTasksList?[indexPath.row].value(forKey: "descriptions") as? String
        editTaskVC.editedTask.date = todoTasksList?[indexPath.row].value(forKey: "date") as? Date
        editTaskVC.editedTask.priority = todoTasksList?[indexPath.row].value(forKey: "priority") as? Int
        editTaskVC.editedTask.state = todoTasksList?[indexPath.row].value(forKey: "state") as? Int
        navigationController?.pushViewController(editTaskVC, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            let deleteAlert : UIAlertController  = UIAlertController(title:"Delete this product?", message:"Are you sure you want to delete this product from cart ?", preferredStyle: .actionSheet)
            deleteAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ [self] action in
                self.coreDataViewModel?.tasksDataBase.deleteTask(id: todoTasksList?[indexPath.row].value(forKey: "id") as! UUID,taskState: 1)
                self.todoTasksList?.remove(at: indexPath.row)
                self.todoTasksTableView.reloadData()
            }))
            deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(deleteAlert, animated:true, completion:nil )
    }
 /*   func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "ToDo Tasks"
    }
 */
}
