//
//  DoneViewController.swift
//  ToDoList
//
//  Created by Fatma on 06/04/2023.
//

import UIKit
import CoreData

class DoneViewController: UIViewController {

    
    var doneTasksList : [NSManagedObject]?
    var coreDataViewModel : CoreDataViewModel?

    @IBOutlet weak var doneTasksTableView: UITableView!
    {
        didSet{
            doneTasksTableView.dataSource = self
            doneTasksTableView.delegate = self
            let nib = UINib(nibName: "TaskTableViewCell", bundle: nil)
            doneTasksTableView.register(nib, forCellReuseIdentifier: "taskCell")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataViewModel = CoreDataViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
            doneTasksList = coreDataViewModel?.tasksDataBase.fetchTasks(state: 3)
            doneTasksTableView.reloadData()
    }
}

extension DoneViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doneTasksList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
        
        cell.taskTitle.text = doneTasksList?[indexPath.row].value(forKey: "title") as? String
        switch doneTasksList?[indexPath.row].value(forKey: "priority") as? Int
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

extension DoneViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}
