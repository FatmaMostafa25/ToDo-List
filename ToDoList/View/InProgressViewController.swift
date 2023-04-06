//
//  InProgressViewController.swift
//  ToDoList
//
//  Created by Fatma on 06/04/2023.
//

import UIKit
import CoreData

class InProgressViewController: UIViewController {

    var inProgressTasksList : [NSManagedObject]?
    var coreDataViewModel : CoreDataViewModel?

    @IBOutlet weak var inProgressTasksTableView: UITableView!
    {
        didSet{
            inProgressTasksTableView.dataSource = self
            inProgressTasksTableView.delegate = self
            let nib = UINib(nibName: "TaskTableViewCell", bundle: nil)
            inProgressTasksTableView.register(nib, forCellReuseIdentifier: "taskCell")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataViewModel = CoreDataViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
            inProgressTasksList = coreDataViewModel?.tasksDataBase.fetchTasks(state: 1)
            inProgressTasksTableView.reloadData()
    }
}

extension InProgressViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inProgressTasksList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
        
        cell.taskTitle.text = inProgressTasksList?[indexPath.row].value(forKey: "title") as? String
        switch inProgressTasksList?[indexPath.row].value(forKey: "priority") as? Int
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

extension InProgressViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}
